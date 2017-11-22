#include <stdlib.h>
#include <stdio.h>

//
// A binary tree node with value and left and right children
struct Node {
  int  value;
  struct Node* left;
  struct Node* right;
};

//
// Insert node n into tree rooted at toNode
//

struct Node* nodeCons(int val){
	struct Node* t0 = (struct Node*) malloc (sizeof(struct Node));
	t0->value=val; 
	t0->left=NULL;
	t0->right=NULL;
	return t0;
}


void insertNode (struct Node* toNode, struct Node* n) {
  if (n->value <= toNode->value) {
        if (toNode->left==NULL)
          toNode->left = n;
        else
          insertNode (toNode->left,n);
      } else {
        if (toNode->right==NULL)
          toNode->right = n;
        else
          insertNode (toNode->right,n);
      }
}

//
// Insert new node with specified value into tree rooted at toNode
//
void insert (struct Node* toNode, int value) {
 	struct Node* toInsert = nodeCons(value);
 	insertNode(toNode,toInsert);
}


//
// Print values of tree rooted at node in ascending order
//
void printInOrder (struct Node* node) {
  if (node->left != NULL)
        printInOrder(node->left);
      printf ("%d\n", node->value);
      if (node->right != NULL)
        printInOrder(node->right);
}

//
// Create root node, insert some values, and print tree in order
//
int main (int argc, char* argv[]) {
  struct Node* t = nodeCons(100);
  insert(t,10);
  insert(t,120);
  insert(t,130);
  insert(t,90);
  insert(t,5);
  insert(t,95);
  insert(t,121);
  insert(t,131);
  insert(t,1);
  printInOrder(t);
}

