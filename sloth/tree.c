#include "tree.h"

/* create a new node */
struct Node * make_node(int type, doublevalue, char * id) {
	int i;
	struct Node * node = (struct Node *) malloc(sizeof(struct Node));
	node->type = type;
	node->value = value;
	strcpy(node->id, id);
	node->num_children = 0;
	for (i = 0; i < MAX_CHILDREN; i++) {
		node->children[i] = NULL;
	}
	return node;
}

/* attach an existing node onto a parent in the parse tree */
void attach_node(struct Node * parent, struct Node * child) {
	parent->children[parent->num_children] = child;
	parent->num_children++;
	assert(parent->num_children <= MAX_CHILDREN);
}
