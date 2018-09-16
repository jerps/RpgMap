/* RPGMAPRBTC.H - RedBlackTree and Cursors header file  */
/* (c) 2017 John Erps (john.erps@gmail.com)          */


#ifndef RPGMAPRBTC_H
#define RPGMAPRBTC_H


typedef unsigned long long numkeys_t;
typedef struct rmb_red_blk_node rmb_red_blk_node;
typedef struct rmb_cursor rmb_cursor;
typedef struct rmb_eventh rmb_eventh;
typedef struct rmb_red_blk_tree rmb_red_blk_tree;
typedef int (*rmb_event_handler)(int event, void* map, void* key, void* item, void* usrd);

rmb_red_blk_tree* RMBTreeCreate(int (*CompFunc)(const void*, const void*, const void*),
                              void (*DestFunc)(void*), void* valstruct);
void RMBTreeSetValstruct(rmb_red_blk_tree* tree, void* valstruct);
void* RMBTreeNodeKey(rmb_red_blk_node* n);
void* RMBTreeNodeItem(rmb_red_blk_node* n);
void RMBTreeDispose(rmb_red_blk_tree*);
rmb_red_blk_node * RMBTreeInsert(rmb_red_blk_tree*, void* key, void* item);
void RMBTreeRmv(rmb_red_blk_tree*, rmb_red_blk_node* z);
numkeys_t RMBTreeNum(rmb_red_blk_tree* tree);
rmb_red_blk_node* RMBTreeGet(rmb_red_blk_tree*, void* key, int firstlast);
int RMBTreeHasKey(rmb_red_blk_tree* tree, void* key);
int RMBTreeHasKeys(rmb_red_blk_tree* tree, void* key, int llgt);
rmb_cursor* RMBCursorCrt(rmb_red_blk_tree* tree, int pos, void* valstruct);
void RMBCursorDispose(rmb_cursor* cursor);
rmb_red_blk_node* RMBCursorNode(rmb_cursor* cursor);
void* RMBCursorKey(rmb_cursor* cursor);
void* RMBCursorItem(rmb_cursor* cursor);
void RMBCursorSetLlGt(rmb_cursor* cursor, void* key, int llgt);
int RMBCursorHasNxtPrv(rmb_cursor* cursor, int nxtprv);
int RMBCursorHasNxtPrv2(rmb_cursor* cursor, int nxtprv, void* key1, void* key2, int opt);
int RMBCursorReadNxtPrv(rmb_cursor* cursor, int nxtprv);
int RMBCursorReadNxtPrv2(rmb_cursor* cursor, int nxtprv, void* key1, void* key2, int opt);
void RMBAddEventh(rmb_red_blk_tree* tree, rmb_event_handler proc, void* usrd);
void RMBRmvEventh(rmb_red_blk_tree* tree, rmb_event_handler proc);
void RMBFireEvent(rmb_red_blk_tree* tree, int event, void* key, void* item);

#endif
