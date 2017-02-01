#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include "tree.h"
#include "parser.tab.h"

/* create a new node */
struct Node * make_node(int type, double value, char * id) {
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

void print_tree(struct Node * node, int tabs) {
	if (!node) return;
	int i;
	for (i = 0; i < tabs; i++) {
		printf("    ");
	}
	
	switch(node->type) {
		case IDENT: printf("IDENTIFIER: %s\n", node->id); break;
		case VALUE: printf("VALUE: %lf\n", node->value); break;
		case PLUS: printf("PLUS:\n"); break;
		case MINUS: printf("MINUS:\n"); break;
		case DIVIDE: printf("DIVIDE:\n"); break;
		case TIMES: printf("TIMES:\n"); break;
		case LTHAN: printf("LTHAN:\n"); break;
		case GTHAN: printf("GTHAN:\n"); break;
		case LTEQL: printf("LTEQL:\n"); break;
		case GTEQL: printf("GTEQL:\n"); break;
		case EQUAL: printf("EQUAL:\n"); break;
		case NOTEQ: printf("NOTEQ:\n"); break;
		case AND: printf("AND:\n"); break;
		case OR: printf("OR:\n"); break;
		case SETEQ: printf("SETEQ:\n"); break;
		case IF: printf("IF:\n"); break;
		case WHILE: printf("WHILE:\n"); break;
		case PRINT: printf("PRINT:\n"); break;
		case INPUT: printf("INPUT:\n"); break;
		case STMT: printf("STMNT:\n"); break;
		default:
			printf("Error, %d not a valid node type.\n", node->type);
			exit(1);
	}
	
	for (i = 0; i < node->num_children; i++) {
		print_tree(node->children[i], tabs + 1);
	}
}
