#include "tree.h"

#ifndef SLOTH_H
#define SLOTH_H

#ifdef __cplusplus
extern "C" {
	struct variable {
		std::string name;
		double value;
	};
	
	int eval_stmt(struct Node * node);
	double eval_expr(struct Node * node);
};
#endif

#endif
