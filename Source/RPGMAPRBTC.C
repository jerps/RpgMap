#pragma comment (copyright, "Copyright (c) 2017 John Erps (john.erps@gmail.com)")


/* RPGMAPRBTC.C - RedBlackTree and Cursors                                */
/* Copyright (c) 2017 John Erps (john.erps@gmail.com)                     */

/* Based on RBT implementation:                                           */
/* http://web.mit.edu/~emin/www.old/source_code/red_black_tree/index.html */
/* Copyright (c) 2001 Emin Martinian                                      */


#include <stdlib.h>
#include "RPGMAPRBTC.H"

/* #define DEBUG_ASSERT 1 */


_Packed struct rmb_red_blk_node {
    void* key;
    void* item;
    struct rmb_red_blk_node* left;
    struct rmb_red_blk_node* right;
    struct rmb_red_blk_node* parent;
    int red; /* if red=0 then the node is black */
};

_Packed struct rmb_cursor {
    /* node is the current node if pos=0 or 1. The current node is the one that */
    /* was last read. The cursor position is just after or just before node, */
    /* depending on whether the last read was a readn (next, pos=1) or a readp */
    /* (previous, pos=0), resp. If pos=10 or 11 then there is no current node and */
    /* if node is NULL the cursor is either at the begin position (pos=10) or at */
    /* the end position (pos=11). If node is not NULL and pos=10 or 11 it marks a */
    /* position after calling RMBCursorPos. When doing a readn (next) node becomes */
    /* the current node if pos=10, or, if pos=11, the node after node becomes */
    /* the current node, if any. If there is no node after node when doing a readn */
    /* or there is no node before node when doing a readp then node becomes NULL. */
    /* valstruct points to the value structure which represents the cursor in */
    /* "value space", of which this struct is a part of. This structure in "value */
    /* space" must be destroyed also when the cursor is destroyed. */
    rmb_red_blk_node* node;
    rmb_red_blk_tree* tree;
    struct rmb_cursor* next;
    void* valstruct;
    int pos;
};

_Packed struct rmb_eventh {
    rmb_event_handler proc;
    void* usrd;
    struct rmb_eventh* prev;
};

/* Compare(a,b) should return 1 if *a > *b, -1 if *a < *b, and 0 otherwise */
/* DestroyObj(a) takes a pointer to key or item and frees it. The pointer can also */
/* point to a data structure in "value space" representing a cursor. When a cursor */
/* is freed then this structure, associated with the cursor, must also be freed. */
_Packed struct rmb_red_blk_tree {
    int (*Compare)(const void* s, const void* a, const void* b);
    void (*DestroyObj)(void* a);
    /* A sentinel is used for root and for nil. These sentinels are */
    /* created when RMBTreeCreate is caled.  root->left should always */
    /* point to the node which is the root of the tree. nil points to a */
    /* node which should always be black but has aribtrary children and */
    /* parent and no key or item.  The point of using these sentinels is so */
    /* that the root and nil nodes do not require special cases in the code */
    /* valstruct points to the value structure which represents the map in */
    /* "value space", of which this struct is a part of. */
    /* valstruct must be passed to the Compare function. */
    rmb_red_blk_node* root;
    rmb_red_blk_node* nil;
    rmb_cursor* cursors;
    rmb_eventh* eventh;
    void* valstruct;
    numkeys_t num;
};


/***********************************************************************/
/*  FUNCTION:  RMBTreeCreate */
/**/
/*  INPUTS:  All the inputs are names of functions.  CompFunc takes two */
/*  void pointers to keys and returns 1 if the first argument is */
/*  "greater than" the second. DestObjlFunc takes a pointer to a key, an */
/*  item or a pointer to a cursor in "value space" and destroys it in the */
/*  appropriate manner when the node containing that key or item is removed */
/*  or when a cursor associated with the tree is destroyed. */
/**/
/*  OUTPUT:  This function returns a pointer to the newly created */
/*  red-black tree. */
/**/
/*  Modifies Input: none */
/***********************************************************************/
rmb_red_blk_tree* RMBTreeCreate( int (*CompFunc) (const void*, const void*,const void*),
			      void (*DestObjFunc) (void*), void* valstruct) {
  rmb_red_blk_tree* newTree;
  rmb_red_blk_node* temp;

  newTree=(rmb_red_blk_tree*) malloc(sizeof(rmb_red_blk_tree));
  newTree->Compare=CompFunc;
  newTree->DestroyObj=DestObjFunc;
  newTree->cursors=NULL;
  newTree->eventh=NULL;
  newTree->valstruct=valstruct;
  newTree->num=0;
  
  /*  see the comment in the rmb_red_blk_tree structure in red_black_tree.h */
  /*  for information on nil and root */
  temp=newTree->nil= (rmb_red_blk_node*) malloc(sizeof(rmb_red_blk_node));
  temp->parent=temp->left=temp->right=temp;
  temp->red=0;
  temp->key=0;
  temp=newTree->root= (rmb_red_blk_node*) malloc(sizeof(rmb_red_blk_node));
  temp->parent=temp->left=temp->right=newTree->nil;
  temp->key=0;
  temp->red=0;
  return(newTree);
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeSetValstruct */
/***********************************************************************/
void RMBTreeSetValstruct(rmb_red_blk_tree* tree, void* valstruct) {
  tree->valstruct = valstruct;
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeNodeKey, RMBTreeNodeItem */
/**/
/*  INPUTS:  a node */
/**/
/*  OUTPUT:  The node's key, or item. */
/**/
/*  Modifies Input: none */
/***********************************************************************/
void* RMBTreeNodeKey(rmb_red_blk_node* n) {
  return n->key;
}
void* RMBTreeNodeItem(rmb_red_blk_node* n) {
  return n->item;
}


/***********************************************************************/
/*  FUNCTION:  RMBFireEvent*/
/**/
/*    INPUTS:  tree is the tree for which to fire event */
/**/
/*    OUTPUT:  none */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/
void RMBFireEvent(rmb_red_blk_tree* tree, int event, void* key, void* item) {
  rmb_eventh* eh = tree->eventh;
  while (NULL != eh) {
    eh->proc(event, tree->valstruct, key, item, eh->usrd);
    eh = eh->prev;
  }
}


/***********************************************************************/
/*  FUNCTION:  RMBLeftRotate */
/**/
/*  INPUTS:  This takes a tree so that it can access the appropriate */
/*           root and nil pointers, and the node to rotate on. */
/**/
/*  OUTPUT:  None */
/**/
/*  Modifies Input: tree, x */
/**/
/*  EFFECTS:  Rotates as described in _Introduction_To_Algorithms by */
/*            Cormen, Leiserson, Rivest (Chapter 14).  Basically this */
/*            makes the parent of x be to the left of x, x the parent of */
/*            its parent before the rotation and fixes other pointers */
/*            accordingly. */
/***********************************************************************/
static void RMBLeftRotate(rmb_red_blk_tree* tree, rmb_red_blk_node* x) {
  rmb_red_blk_node* y;
  rmb_red_blk_node* nil=tree->nil;

  /*  I originally wrote this function to use the sentinel for */
  /*  nil to avoid checking for nil.  However this introduces a */
  /*  very subtle bug because sometimes this function modifies */
  /*  the parent pointer of nil.  This can be a problem if a */
  /*  function which calls RMBLeftRotate also uses the nil sentinel */
  /*  and expects the nil sentinel's parent pointer to be unchanged */
  /*  after calling this function.  For example, when RMBDeleteFixUP */
  /*  calls RMBLeftRotate it expects the parent pointer of nil to be */
  /*  unchanged. */

  y=x->right;
  x->right=y->left;

  if (y->left != nil) y->left->parent=x; /* used to use sentinel here */
  /* and do an unconditional assignment instead of testing for nil */

  y->parent=x->parent;

  /* instead of checking if x->parent is the root as in the book, we */
  /* count on the root sentinel to implicitly take care of this case */
  if( x == x->parent->left) {
    x->parent->left=y;
  } else {
    x->parent->right=y;
  }
  y->left=x;
  x->parent=y;

#ifdef DEBUG_ASSERT
  Assert(!tree->nil->red,"nil not red in RMBLeftRotate");
#endif
}


/***********************************************************************/
/*  FUNCTION:  RMBRightRotate */
/**/
/*  INPUTS:  This takes a tree so that it can access the appropriate */
/*           root and nil pointers, and the node to rotate on. */
/**/
/*  OUTPUT:  None */
/**/
/*  Modifies Input?: tree, y */
/**/
/*  EFFECTS:  Rotates as described in _Introduction_To_Algorithms by */
/*            Cormen, Leiserson, Rivest (Chapter 14).  Basically this */
/*            makes the parent of x be to the left of x, x the parent of */
/*            its parent before the rotation and fixes other pointers */
/*            accordingly. */
/***********************************************************************/
static void RMBRightRotate(rmb_red_blk_tree* tree, rmb_red_blk_node* y) {
  rmb_red_blk_node* x;
  rmb_red_blk_node* nil=tree->nil;

  /*  I originally wrote this function to use the sentinel for */
  /*  nil to avoid checking for nil.  However this introduces a */
  /*  very subtle bug because sometimes this function modifies */
  /*  the parent pointer of nil.  This can be a problem if a */
  /*  function which calls RMBLeftRotate also uses the nil sentinel */
  /*  and expects the nil sentinel's parent pointer to be unchanged */
  /*  after calling this function.  For example, when RMBDeleteFixUP */
  /*  calls RMBLeftRotate it expects the parent pointer of nil to be */
  /*  unchanged. */

  x=y->left;
  y->left=x->right;

  if (nil != x->right)  x->right->parent=y; /*used to use sentinel here */
  /* and do an unconditional assignment instead of testing for nil */

  /* instead of checking if x->parent is the root as in the book, we */
  /* count on the root sentinel to implicitly take care of this case */
  x->parent=y->parent;
  if( y == y->parent->left) {
    y->parent->left=x;
  } else {
    y->parent->right=x;
  }
  x->right=y;
  y->parent=x;

#ifdef DEBUG_ASSERT
  Assert(!tree->nil->red,"nil not red in RMBRightRotate");
#endif
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeInsertHelp  */
/**/
/*  INPUTS:  tree is the tree into which node z is inserted */
/**/
/*  OUTPUT:  none */
/**/
/*  Modifies Input:  tree, z */
/**/
/*  EFFECTS:  Inserts z into the tree as if it were a regular binary tree */
/*            using the algorithm described in _Introduction_To_Algorithms_ */
/*            by Cormen et al.  This funciton is only intended to be called */
/*            by the RMBTreeAdd function and not by the user */
/***********************************************************************/
static void RMBTreeInsertHelp(rmb_red_blk_tree* tree, rmb_red_blk_node* z) {
  /*  This function should only be called by InsertRMBTree (see above) */
  rmb_red_blk_node* x;
  rmb_red_blk_node* y;
  rmb_red_blk_node* nil=tree->nil;

  z->left=z->right=nil;
  y=tree->root;
  x=tree->root->left;
  while( x != nil) {
    y=x;
    if (1 == tree->Compare(tree->valstruct,x->key,z->key)) { /* x.key > z.key */
      x=x->left;
    } else { /* x,key <= z.key */
      x=x->right;
    }
  }
  z->parent=y;
  if ( (y == tree->root) ||
       (1 == tree->Compare(tree->valstruct,y->key,z->key))) { /* y.key > z.key */
    y->left=z;
  } else {
    y->right=z;
  }

#ifdef DEBUG_ASSERT
  Assert(!tree->nil->red,"nil not red in RMBTreeInsertHelp");
#endif
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeInsert */
/**/
/*  INPUTS:  tree is the red-black tree into which a new node is inserted */
/*           with key and item */
/**/
/*  OUTPUT:  This function returns a pointer to the newly inserted node */
/*           which is guarunteed to be valid until this node is deleted. */
/*           What this means is if another data structure stores this */
/*           pointer then the tree does not need to be searched when this */
/*           is to be deleted. */
/**/
/*  Modifies Input: tree */
/**/
/*  EFFECTS:  Creates a node node which contains the appropriate key and */
/*            item pointers and inserts it into the tree. */
/***********************************************************************/
rmb_red_blk_node * RMBTreeInsert(rmb_red_blk_tree* tree, void* key, void* item) {
  rmb_red_blk_node * y;
  rmb_red_blk_node * x;
  rmb_red_blk_node * newNode;
  
  x=(rmb_red_blk_node*) malloc(sizeof(rmb_red_blk_node));
  x->key=key;
  x->item=item;

  RMBTreeInsertHelp(tree,x);
  newNode=x;
  x->red=1;
  while(x->parent->red) { /* use sentinel instead of checking for root */
    if (x->parent == x->parent->parent->left) {
      y=x->parent->parent->right;
      if (y->red) {
	x->parent->red=0;
	y->red=0;
	x->parent->parent->red=1;
	x=x->parent->parent;
      } else {
	if (x == x->parent->right) {
	  x=x->parent;
	  RMBLeftRotate(tree,x);
	}
	x->parent->red=0;
	x->parent->parent->red=1;
	RMBRightRotate(tree,x->parent->parent);
      } 
    } else { /* case for x->parent == x->parent->parent->right */
      y=x->parent->parent->left;
      if (y->red) {
	x->parent->red=0;
	y->red=0;
	x->parent->parent->red=1;
	x=x->parent->parent;
      } else {
	if (x == x->parent->left) {
	  x=x->parent;
	  RMBRightRotate(tree,x);
	}
	x->parent->red=0;
	x->parent->parent->red=1;
	RMBLeftRotate(tree,x->parent->parent);
      } 
    }
  }
  tree->root->left->red=0;
  tree->num++;
  return(newNode);

#ifdef DEBUG_ASSERT
  Assert(!tree->nil->red,"nil not red in RMBTreeInsert");
  Assert(!tree->root->red,"root not red in RMBTreeInsert");
#endif
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeSuccessor  */
/**/
/*    INPUTS:  tree is the tree in question, and x is the node we want the */
/*             the successor of. */
/**/
/*    OUTPUT:  This function returns the successor of x or nil if no */
/*             successor exists. */
/**/
/*    Modifies Input: none */
/**/
/*    Note:  uses the algorithm in _Introduction_To_Algorithms_ */
/***********************************************************************/
static rmb_red_blk_node* RMBTreeSuccessor(rmb_red_blk_tree* tree,rmb_red_blk_node* x) {
  rmb_red_blk_node* y;
  rmb_red_blk_node* nil=tree->nil;
  rmb_red_blk_node* root=tree->root;

  if (nil != (y = x->right)) { /* assignment to y is intentional */
    while(y->left != nil) { /* returns the minium of the right subtree of x */
      y=y->left;
    }
    return(y);
  } else {
    y=x->parent;
    while(x == y->right) { /* sentinel used instead of checking for nil */
      x=y;
      y=y->parent;
    }
    if (y == root) return(nil);
    return(y);
  }
}


/***********************************************************************/
/*  FUNCTION:  RMBTreePredecessor  */
/**/
/*    INPUTS:  tree is the tree in question, and x is the node we want the */
/*             the predecessor of. */
/**/
/*    OUTPUT:  This function returns the predecessor of x or nil if no */
/*             predecessor exists. */
/**/
/*    Modifies Input: none */
/**/
/*    Note:  uses the algorithm in _Introduction_To_Algorithms_ */
/***********************************************************************/
static rmb_red_blk_node* RMBTreePredecessor(rmb_red_blk_tree* tree, rmb_red_blk_node* x) {
  rmb_red_blk_node* y;
  rmb_red_blk_node* nil=tree->nil;
  rmb_red_blk_node* root=tree->root;

  if (nil != (y = x->left)) { /* assignment to y is intentional */
    while(y->right != nil) { /* returns the maximum of the left subtree of x */
      y=y->right;
    }
    return(y);
  } else {
    y=x->parent;
    while(x == y->left) {
      if (y == root) return(nil);
      x=y;
      y=y->parent;
    }
    return(y);
  }
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeDisposeHelper */
/**/
/*    INPUTS:  tree is the tree to dispose and x is the current node */
/**/
/*    OUTPUT:  none  */
/**/
/*    EFFECTS:  This function recursively destroys the nodes of the tree */
/*              postorder using the DestroyVal function. */
/**/
/*    Modifies Input: tree, x */
/**/
/*    Note:    This function should only be called by RMBTreeDestroy */
/***********************************************************************/
static void RMBTreeDisposeHelper(rmb_red_blk_tree* tree, rmb_red_blk_node* x) {
  rmb_red_blk_node* nil=tree->nil;
  if (x != nil) {
    RMBTreeDisposeHelper(tree,x->left);
    RMBTreeDisposeHelper(tree,x->right);
    tree->DestroyObj(x->key);
    tree->DestroyObj(x->item);
    free(x);
  }
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeDispose */
/**/
/*    INPUTS:  tree is the tree to dispose */
/**/
/*    OUTPUT:  none */
/**/
/*    EFFECT:  Destroys the tree and frees memory */
/**/
/*    Modifies Input: tree */
/**/
/***********************************************************************/
void RMBTreeDispose(rmb_red_blk_tree* tree) {
  RMBTreeDisposeHelper(tree,tree->root->left);
  free(tree->root);
  free(tree->nil);
  rmb_cursor* c = tree->cursors;
  while (NULL != c) {
    rmb_cursor* x = c;
    tree->DestroyObj(c->valstruct);
    c = c->next;
    free(x);
  }
  rmb_eventh* eh = tree->eventh;
  while (NULL != eh) {
    rmb_eventh* x = eh;
    eh = eh->prev;
    free(x);
  }
  free(tree);
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeRmvFixUp */
/**/
/*    INPUTS:  tree is the tree to fix and x is the child of the spliced */
/*             out node in RMBTreeRmv. */
/**/
/*    OUTPUT:  none */
/**/
/*    EFFECT:  Performs rotations and changes colors to restore red-black */
/*             properties after a node is removed */
/**/
/*    Modifies Input: tree, x */
/**/
/*    The algorithm from this function is from _Introduction_To_Algorithms_ */
/***********************************************************************/
static void RMBTreeRmvFixUp(rmb_red_blk_tree* tree, rmb_red_blk_node* x) {
  rmb_red_blk_node* root=tree->root->left;
  rmb_red_blk_node* w;

  while( (!x->red) && (root != x)) {
    if (x == x->parent->left) {
      w=x->parent->right;
      if (w->red) {
	w->red=0;
	x->parent->red=1;
	RMBLeftRotate(tree,x->parent);
	w=x->parent->right;
      }
      if ( (!w->right->red) && (!w->left->red) ) { 
	w->red=1;
	x=x->parent;
      } else {
	if (!w->right->red) {
	  w->left->red=0;
	  w->red=1;
	  RMBRightRotate(tree,w);
	  w=x->parent->right;
	}
	w->red=x->parent->red;
	x->parent->red=0;
	w->right->red=0;
	RMBLeftRotate(tree,x->parent);
	x=root; /* this is to exit while loop */
      }
    } else { /* the code below is has left and right switched from above */
      w=x->parent->left;
      if (w->red) {
	w->red=0;
	x->parent->red=1;
	RMBRightRotate(tree,x->parent);
	w=x->parent->left;
      }
      if ( (!w->right->red) && (!w->left->red) ) { 
	w->red=1;
	x=x->parent;
      } else {
	if (!w->left->red) {
	  w->right->red=0;
	  w->red=1;
	  RMBLeftRotate(tree,w);
	  w=x->parent->left;
	}
	w->red=x->parent->red;
	x->parent->red=0;
	w->left->red=0;
	RMBRightRotate(tree,x->parent);
	x=root; /* this is to exit while loop */
      }
    }
  }
  x->red=0;
  tree->num--;

#ifdef DEBUG_ASSERT
  Assert(!tree->nil->red,"nil not black in RMBDeleteFixUp");
#endif
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeRmv */
/**/
/*    INPUTS:  tree is the tree to remove node z from */
/**/
/*    OUTPUT:  none */
/**/
/*    EFFECT:  Removes z from tree and frees the key and item of z */
/*             using DestroyObj.  Then calls RMBTreeRmvFixUp to restore */
/*             red-black properties */
/*             If node z is also the current or positioning node of a cursor then */
/*             the predecessor or successor will become the new positioning node, */
/*             depending on whether the cursor is positioned just before (pos=0 or */
/*             10) or just after (pos=1 or 11) the current or positioning node, resp. */
/*             If there is no predecessor or successor the cursor is positioned at */
/*             the begin or end position. If the predecessor becomes the new */
/*             positioning node then the cursor is positioned just after it, if */
/*             the successor becomes the new node the cursor is positioned just */
/*             before it. */
/**/
/*    Modifies Input: tree, z */
/**/
/*    The algorithm from this function is from _Introduction_To_Algorithms_ */
/***********************************************************************/
void RMBTreeRmv(rmb_red_blk_tree* tree, rmb_red_blk_node* z){
  rmb_red_blk_node* y;
  rmb_red_blk_node* x;
  rmb_red_blk_node* nil=tree->nil;
  rmb_red_blk_node* root=tree->root;
  rmb_red_blk_node* zp = NULL;
  rmb_red_blk_node* zs = NULL;

  RMBFireEvent(tree, 2, z->key, z->item);

  rmb_cursor* c = tree->cursors;
  while (NULL != c) {
    if (NULL != c->node && c->node == z) {
      if (0 == c->pos || 10 == c->pos) {
        if (NULL == zp)
          zp = RMBTreePredecessor(tree, z);
        if (nil == zp) {
          c->node = NULL;
          c->pos = 10;
        } else {
          c->node = zp;
          c->pos = 11;
        }
      } else {
        if (NULL == zs)
          zs = RMBTreeSuccessor(tree, z);
        if (nil == zs)  {
          c->node = NULL;
          c->pos = 11;
        } else {
          c->node = zs;
          c->pos = 10;
        }
      }
    }
    c=c->next;
  }
  y= ((z->left == nil) || (z->right == nil)) ? z :
         (zs !=NULL ? zs : RMBTreeSuccessor(tree,z));
  x= (y->left == nil) ? y->right : y->left;
  if (root == (x->parent = y->parent)) { /* assignment of y->p to x->p is intentional */
    root->left=x;
  } else {
    if (y == y->parent->left) {
      y->parent->left=x;
    } else {
      y->parent->right=x;
    }
  }
  if (y != z) { /* y should not be nil in this case */

#ifdef DEBUG_ASSERT
    Assert( (y!=tree->nil),"y is nil in RMBTreeRmv");
#endif
    /* y is the node to splice out and x is its child */

    if (!(y->red)) RMBTreeRmvFixUp(tree,x);

    tree->DestroyObj(z->key);
    tree->DestroyObj(z->item);
    y->left=z->left;
    y->right=z->right;
    y->parent=z->parent;
    y->red=z->red;
    z->left->parent=z->right->parent=y;
    if (z == z->parent->left) {
      z->parent->left=y;
    } else {
      z->parent->right=y;
    }
    free(z);
  } else {
    tree->DestroyObj(y->key);
    tree->DestroyObj(y->item);
    if (!(y->red)) RMBTreeRmvFixUp(tree,x);
    free(y);
  }

#ifdef DEBUG_ASSERT
  Assert(!tree->nil->red,"nil not black in RMBTreeRmv");
#endif
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeNum */
/**/
/*    INPUTS:  tree is the tree for which we want to know the number of */
/*             key/item pairs. */
/**/
/*    OUTPUT:  Returns the number of key/item pairs. */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/
numkeys_t RMBTreeNum(rmb_red_blk_tree* tree) {
  return tree->num;
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeGet */
/**/
/*    INPUTS:  tree is the tree from which to get a node with key */
/*             equal to key */
/**/
/*    OUTPUT:  Returns a node with key equal to key, or returns NULL if key */
/*             is not found. If there are multiple nodes with key equal to */
/*             key then if firstlast is 0 the node with this key that was */
/*             first added is returned, else the node that was last added */
/*             is returned. */
/**/
/*    NOTE:    When there are duplicates of key, the search among these keys */
/*             has comp. complexity K (not log K), where K is the number of */
/*             equal keys */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/
rmb_red_blk_node* RMBTreeGet(rmb_red_blk_tree* tree, void* key, int firstlast) {
  rmb_red_blk_node* x=tree->root->left;
  rmb_red_blk_node* nil=tree->nil;
  int compVal;
  if (x == nil) return NULL;
  compVal=tree->Compare(tree->valstruct,x->key, key);
  while(0 != compVal) {
    if (1 == compVal) { /* x->key > key */
      x=x->left;
    } else {
      x=x->right;
    }
    if (x == nil) return NULL;
    compVal=tree->Compare(tree->valstruct, x->key, key);
  }
  if (0 == firstlast)
    while (nil != x->left && 0 == tree->Compare(tree->valstruct, x->left->key, key))
      x=x->left;
  else
    while (nil != x->right && 0 == tree->Compare(tree->valstruct, x->right->key, key))
      x=x->right;
  return x;
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeHasKey */
/**/
/*    INPUTS:  tree is the tree for which we want to know whether */
/*             it has a key. */
/**/
/*    OUTPUT:  return 1 if tree has a key that is equal to key, */
/*             else return 0. */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/
int RMBTreeHasKey(rmb_red_blk_tree* tree, void* key) {
  rmb_red_blk_node* x=tree->root->left;
  rmb_red_blk_node* nil=tree->nil;
  int compVal;
  if (x == nil) return 0;
  compVal=tree->Compare(tree->valstruct, x->key, key);
  while(0 != compVal) {
    if (1 == compVal) { /* x->key > key */
      x=x->left;
    } else {
      x=x->right;
    }
    if (x == nil) return 0;
    compVal=tree->Compare(tree->valstruct, x->key, key);
  }
  return 1;
}


/***********************************************************************/
/*  FUNCTION:  RMBTreeHasKeys */
/**/
/*    INPUTS:  tree is the tree for which we want to know whether */
/*             it has keys before or after key */
/**/
/*    OUTPUT:  return 1 if tree has at least one key that is equal to */
/*             or greater (llgt==0) than key or at least one key that is */
/*             equal to or less (llgt!=0) than key, else return 0. */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/
int RMBTreeHasKeys(rmb_red_blk_tree* tree, void* key, int llgt) {
  rmb_red_blk_node* nil=tree->nil;
  rmb_red_blk_node* x=tree->root->left;
  while (nil != x
      && ((0 == llgt && 1 == tree->Compare(tree->valstruct, key, x->key))
          || (0 != llgt && 1 == tree->Compare(tree->valstruct, x->key, key))))
    if (0 == llgt)
      x = x->right;
    else;
      x = x->left;
  return nil == x ? 0 : 1;
}


/***********************************************************************/
/*  FUNCTION:  RMBCursorCrt */
/**/
/*    INPUTS:  tree is the tree for which to create a new cursor; */
/*             pos indicates where to position it (0=begin, other=end). */
/*             valstruct points to the cursor's structure in "value space" */
/*             which must be disposed when the cursor is disposed. */
/**/
/*    OUTPUT:  pointer to new cursor, positioned at begin or end */
/**/
/*    Modifies Input: tree */
/**/
/***********************************************************************/
rmb_cursor* RMBCursorCrt(rmb_red_blk_tree* tree, int pos, void* valstruct) {
  rmb_cursor* c = tree->cursors;
  rmb_cursor* p = NULL;
  while (NULL != c) {
    p = c;
    c=c->next;
  }
  c = (rmb_cursor*) malloc(sizeof(rmb_cursor));
  c->pos = 0 == pos ? 10 : 11;
  c->node = NULL;
  c->tree = tree;
  c->next = NULL;
  c->valstruct = valstruct;
  if (NULL == p)
    tree->cursors = c;
  else
    p->next = c;
  return c;
}


/***********************************************************************/
/*  FUNCTION:  RMBCursorDispose */
/**/
/*    INPUTS:  cursor is the cursor to dispose */
/**/
/*    OUTPUT:  none */
/**/
/*    Modifies Input: cursor */
/**/
/***********************************************************************/
void RMBCursorDispose(rmb_cursor* cursor) {
  rmb_red_blk_tree* t = cursor->tree;
  rmb_cursor* n = cursor->next;
  rmb_cursor* c = t->cursors;
  rmb_cursor* p = NULL;  
  while (NULL != c && cursor != c) {
    p = c;
    c=c->next;
  }
  if (NULL == c) /* shouldn't happen */
    return;
  t->DestroyObj(c->valstruct);
  free(c);
  if (NULL == p)
    t->cursors = n;
  else
    p->next = n;
}


/***********************************************************************/
/*  FUNCTION:  RMBCursorNode */
/**/
/*    INPUTS:  cursor is the cursor which has a current node, or not */
/**/
/*    OUTPUT:  return a pointer to the current node, or NULL if the */
/*             cursor has no current node */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/
rmb_red_blk_node* RMBCursorNode(rmb_cursor* cursor) {
  return cursor->node == NULL || 10 == cursor->pos || 11 == cursor->pos
      ? NULL : cursor->node;
}


/***********************************************************************/
/*  FUNCTION:  RMBCursorKey, RMBCursorItem */
/**/
/*    INPUTS:  cursor is the cursor which has a current node, or not */
/**/
/*    OUTPUT:  return a pointer to the current node's key or value, or */
/*             NULL if the cursor has no current node */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/
void* RMBCursorKey(rmb_cursor* cursor) {
  return cursor->node == NULL || 10 == cursor->pos || 11 == cursor->pos
      ? NULL : cursor->node->key;
}
void* RMBCursorItem(rmb_cursor* cursor) {
  return cursor->node == NULL || 10 == cursor->pos || 11 == cursor->pos
      ? NULL : cursor->node->item;
}


/***********************************************************************/
/*  FUNCTION:  RMBCursorSetLlGt */
/**/
/*    INPUTS:  cursor is the cursor to position on key; if llgt=0 then */
/*             a setll is done, i.e. the cursor is positioned just before */
/*             the lowest key that is equal to or greater then key. Else */
/*             a setgt is done, i.e. the cursor is positioned just after */
/*             the highest key that is equal to or less than key. If key */
/*             is NULL the cursor will be positioned at the begin (llgt=0) */
/*             or at the end position (llgt!=0). If llgt=0 and there is no */
/*             key equal to or higher than key then the cursor will be */
/*             positioned at the end position. If llgt!=0 and there is no key */
/*             equal to or less than key then the cursor will be positioned */
/*             at the begin position. */
/**/
/*    OUTPUT:  none */
/**/
/*    Modifies Input: cursor */
/**/
/***********************************************************************/
void RMBCursorSetLlGt(rmb_cursor* cursor, void* key, int llgt) {
  if (NULL == key) {
    cursor->pos = 0 == llgt ? 10 : 11;
    cursor->node = NULL;
    return;
  }
  rmb_red_blk_tree* t = cursor->tree;  
  rmb_red_blk_node* nil=t->nil;
  rmb_red_blk_node* x=t->root->left;
  rmb_red_blk_node* lastBest=nil;
  while (nil != x) {
    if (0 == llgt) {
      if (1 == (t->Compare(t->valstruct, key, x->key)) ) { /* x->key < key */
        x=x->right;
      } else {
        lastBest=x;
        x=x->left;
      }
    } else {
      if (1 == (t->Compare(t->valstruct, x->key, key)) ) { /* x->key > key */
        x=x->left;
      } else {
        lastBest=x;
        x=x->right;
      }
    }
  }
  if (nil == lastBest) {
    cursor->pos = 0 == llgt ? 11 : 10;
    cursor->node = NULL;
    return;
  }
  cursor->pos = 0 == llgt ? 10 : 11;
  cursor->node = lastBest;
}


/***********************************************************************/
/*  FUNCTION:  RMBCursorHasNxtPrv/RMBCursorHasNxtPrv2 */
/**/
/*    INPUTS:  cursor is the cursor for which we want to know if there is */
/*             a next (nxtprv=0) or previous (nxtprv!=0) node. The next or */
/*             previous node's key must be between key1 and key2. If key1 */
/*             is NULL it's the lowest key; if key2 is NULL it's the highest */
/*             key. If opt = 1 then there is no next or previous key. If */
/*             opt = 2 then the next/prev node's key must be equal to key1. */
/**/
/*    OUTPUT:  return 1 if there is a next/previous node, else return 0. */
/**/
/*    NOTE:    This function takes almost as much time as RMBCursorReadNxtPrv. */
/*             The difference is that this function doesn't modify cursor. */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/
int RMBCursorHasNxtPrv(rmb_cursor* cursor, int nxtprv)  {
  return RMBCursorHasNxtPrv2(cursor, nxtprv, NULL, NULL, 0);
}
int RMBCursorHasNxtPrv2(rmb_cursor* cursor, int nxtprv, void* key1, void* key2, int opt) {
  rmb_red_blk_node* n;
  if (NULL == cursor->node 
      && (0 == nxtprv && 11 == cursor->pos
          || 0 != nxtprv && 10 == cursor->pos))
    return 0;
  if (NULL == cursor->node && 10 != cursor->pos && 11 != cursor->pos)
    return 0; // shouldn't happen
  if (1 == opt)
    return 0;
  rmb_red_blk_tree* t = cursor->tree;  
  rmb_red_blk_node* nil=t->nil;
  if (NULL == cursor->node) {
    n = t->root->left;
    if (   nil == n
        || 2 == opt && 0 != t->Compare(t->valstruct,key1,n->key)
        || key1 != NULL && 1 == t->Compare(t->valstruct,key1,n->key)
        || key2 != NULL && -1 == t->Compare(t->valstruct,key2,n->key))
      return 0;
    return 1;
  }
  n = cursor->node;
  if (0 == nxtprv && (1 == cursor->pos || 11 == cursor->pos))
    n = RMBTreeSuccessor(t, n);
  if (0 != nxtprv && (0 == cursor->pos || 10 == cursor->pos))
    n = RMBTreePredecessor(t, n);
  if (   nil == n
      || 2 == opt && 0 != t->Compare(t->valstruct,key1,n->key)
      || key1 != NULL && 1 == t->Compare(t->valstruct,key1,n->key)
      || key2 != NULL && -1 == t->Compare(t->valstruct,key2,n->key))
    return 0;
  return 1;
}


/***********************************************************************/
/*  FUNCTION:  RMBCursorReadNxtPrv/RMBCursorReadNxtPrv2 */
/**/
/*    INPUTS:  cursor is the cursor for which we want to read the next */
/*             (nxtprv=0) or previous (nxtprv!=0) node, which becomes */
/*             the current node. If there is no next or previous node then */
/*             the cursor will be positioned at the end or begin position, */
/*             resp. The next or previous node's key must be between key1 */
/*             and key2. If key1 is NULL it's the lowest key; if key2 is */
/*             NULL it's the highest key. If opt = 1 then there is no */
/*             next or previous key. If opt = 2 then the next/prev node's */
/*             key must be equal to key1. */
/**/
/*    OUTPUT:  return 1 if there was a next/previous node, which now is */
/*             the current node, else return 0. */
/**/
/*    Modifies Input: cursor */
/**/
/***********************************************************************/
int RMBCursorReadNxtPrv(rmb_cursor* cursor, int nxtprv) {
  return RMBCursorReadNxtPrv2(cursor, nxtprv, NULL, NULL, 0);
}
int RMBCursorReadNxtPrv2(rmb_cursor* cursor, int nxtprv, void* key1, void* key2, int opt) {
  if (NULL == cursor->node 
      && (0 == nxtprv && 11 == cursor->pos
          || 0 != nxtprv && 10 == cursor->pos))
    return 0;
  if (NULL == cursor->node && 10 != cursor->pos && 11 != cursor->pos)
    return 0; // shouldn't happen
  if (1 == opt) {
    cursor->node = NULL;
    cursor->pos = 0 == nxtprv ? 11 : 10;
    return 0;
  }
  rmb_red_blk_tree* t = cursor->tree;  
  rmb_red_blk_node* nil=t->nil;
  rmb_red_blk_node* n;
  if (NULL == cursor->node) {
    // search highest/lowest key
    rmb_red_blk_node* x=t->root->left;
    n=nil;
    while (nil != x) {
      n = x;
      if (10 == cursor->pos)
        x=x->left;
      else
        x=x->right;
    }
    if (   nil == n
        || 2 == opt && 0 != t->Compare(t->valstruct,key1,n->key)
        || key1 != NULL && 1 == t->Compare(t->valstruct,key1,n->key)
        || key2 != NULL && -1 == t->Compare(t->valstruct,key2,n->key)) {
      cursor->pos = 10 == cursor->pos ? 11 : 10;
      return 0;
    }
    cursor->node = n;
    cursor->pos = 0 == nxtprv ? 1 : 0;
    return 1;
  }
  n = cursor->node;
  if (0 == nxtprv && (1 == cursor->pos || 11 == cursor->pos))
    n = RMBTreeSuccessor(t, n);
  if (0 != nxtprv && (0 == cursor->pos || 10 == cursor->pos))
    n = RMBTreePredecessor(t, n);
  if (   nil == n
      || 2 == opt && 0 != t->Compare(t->valstruct,key1,n->key)
      || key1 != NULL && 1 == t->Compare(t->valstruct,key1,n->key)
      || key2 != NULL && -1 == t->Compare(t->valstruct,key2,n->key)) {
    cursor->node = NULL;
    cursor->pos = 0 == nxtprv ? 11 : 10;
    return 0;
  }
  cursor->node = n;
  cursor->pos = 0 == nxtprv ? 1 : 0;
  return 1;
}


/***********************************************************************/
/*  FUNCTION:  RMBAddEventh */
/**/
/*    INPUTS:  tree is the tree to which to add eh */
/**/
/*    OUTPUT:  none */
/**/
/*    Modifies Input: tree */
/**/
/***********************************************************************/
void RMBAddEventh(rmb_red_blk_tree* tree, rmb_event_handler proc, void* usrd) {
  rmb_eventh* eh = (rmb_eventh*) malloc(sizeof(rmb_eventh));
  eh->proc = proc;
  eh->usrd = usrd;
  eh->prev = tree->eventh;
  tree->eventh = eh;
}


/***********************************************************************/
/*  FUNCTION:  RMBRmvEventh */
/**/
/*    INPUTS:  tree is the tree from which to remove eh */
/**/
/*    OUTPUT:  none */
/**/
/*    Modifies Input: tree */
/**/
/***********************************************************************/
void RMBRmvEventh(rmb_red_blk_tree* tree, rmb_event_handler proc) {
  rmb_eventh* eh = tree->eventh;
  rmb_eventh* p = NULL;
  while (NULL != eh && eh->proc != proc) {
    p = eh;
    eh = eh->prev;
  }
  if (NULL == eh)
    return;
  if (NULL == p)
    tree->eventh = eh->prev;
  else
    p->prev = eh->prev;
  free(eh);
}
