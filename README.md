operators
=========

These matlab files are implementation of the algebra of creation and anihilation operators
by overloading standart matlab binary operators.

The creation and anihilation opeators act on a configuration (state in Fock space)
which is represented by a binary array, e.g. [1 0 0 0]. The init means occupied state and
zero means empty state.

Example of usage:
Suppose we have five orbitals. In this case, we have to initialize bunch of creation and anihilation 
operators applying a class constructor:

a=OperatorFermion(1:5);

The action of the anihilation opeator is designated by the matrix product "\*" and
the action of the creation operator is desigated by the product with a dot ".\*".
The orbital index of the operator should be placed in parenthesis:

a(1).*[0 0 0 0 0];

>> ans=
       1 0 0 0 0

a(2).\*a(1).\*[0 0 0 0 0];

>> ans=
       1 1 0 0 0
       
a(1)\*a(2).\*a(1).*[0 0 0 0 0];

>> ans=
       0 1 0 0 0       
       
a(1)\*a(1).\*a(2).*[0 0 0 0 0];

>> ans=
       0 -1 0 0 0            
       
The sign means phase factor following from the comutation rules for operators.
