#ifndef TREE_H
#define TREE_H

#define ID_SIZE 100
#define MAX_CHILDREN 3

struct Node {
	int type;
	double value;
	char id[ID_SIZE];
	int num_children;
	struct Node * children[MAX_CHILDREN]
};

struct Node * make_node(int, double, char*);
void attach_node(struct Node*, struct Node*);


#endif
