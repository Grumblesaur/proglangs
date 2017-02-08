#include <iostream>
#include <string>
#include <map>
#include "parser.tab.h"
#include "sloth.h"
#include "tree.h"

std::map<std::string, double> variables;

double eval_expr(struct Node *);

int eval_stmt(struct Node * node) {
	struct variable v;
	std::string name;
	
	switch (node->type) {
		case SETEQ:
			name = (node->children[0])->id;
			variables[name] = eval_expr(node->children[1]);
			break;
		
		case WHILE:
			while (node->children[0] != 0) {
				eval_stmt(node->children[1]);
			}
			break;
		
		case PRINT:
			std::cerr << eval_expr(node->children[0]) << std::endl;
			break;
		
		case START:
			for (int i = 0; i < node->num_children; i++) {
				eval_stmt(node->children[i]);
			}
			break;
			
		case IF:
			if (node->num_children == 2) {
				if (eval_expr(node->children[1])) {
					eval_stmt(node->children[2]);
				}
			} else {
				if (eval_expr(node->children[1])) {
					eval_stmt(node->children[2]);
				} else {
					eval_stmt(node->children[3]);
				}
			}
			break;
			
		default:
			break;
	}
	return 0;
}

double eval_expr(struct Node * node) {
	switch (node->type) {
		case OR:
			return (double) eval_expr(node->children[0])
				|| eval_expr(node->children[1]);
				break;

		case AND:
			return (double) eval_expr(node->children[0])
				&& eval_expr(node->children[1]);
				break;

		case LTHAN:
			return (double) eval_expr(node->children[0])
				< eval_expr(node->children[1]);
				break;

		case GTHAN:
			return (double) eval_expr(node->children[0])
				> eval_expr(node->children[1]);
				break;
		
		case LTEQL:
			return (double) eval_expr(node->children[0])
				<= eval_expr(node->children[1]);
				break;
		
		case GTEQL:
			return (double) eval_expr(node->children[0])
				>= eval_expr(node->children[1]);
				break;

		case EQUAL:
			return (double) eval_expr(node->children[0])
				== eval_expr(node->children[1]);
				break;

		case NOTEQ:
			return (double) eval_expr(node->children[0])
				!= eval_expr(node->children[1]);
				break;

		case PLUS:
			return eval_expr(node->children[0])
				+ eval_expr(node->children[1]);
				break;
			
		case MINUS:
			return eval_expr(node->children[0])
				- eval_expr(node->children[1]);
				break;
			
		case TIMES:
			return eval_expr(node->children[0])
				* eval_expr(node->children[1]);
				break;
			
		case DIVIDE:
			return eval_expr(node->children[0])
				/ eval_expr(node->children[1]);
				break;
			
		case NOT:
			return (double) !eval_expr(node->children[0]);
			break;

		case OPPAR:
			return eval_expr(node->children[0]);
			break;

		case IDENT:
			return variables[node->id];
			break;

		case VALUE:
			return node->value;
			break;

		case INPUT:
			double d;
			std::cin >> d;
			return d;
			break;
			
		default:
			break;
	}
	return 0;
}
