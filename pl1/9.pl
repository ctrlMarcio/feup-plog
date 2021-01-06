% GIVEN IN THE ASSIGNMENT
student(joao, paradigmas).
student(maria, paradigmas).
student(joel, lab2).
student(joel, estruturas).
frequents(joao, feup).
frequents(maria, feup).
frequents(joel, ist).
teacher(carlos, paradigmas).
teacher(ana_paula, estruturas).
teacher(pedro, lab2).
employee(pedro, ist).
employee(ana_paula, feup).
employee(carlos, feup).

% a)
teachers_student(Teacher, Student) :-
    teacher(Teacher, Course),
    employee(Teacher, College),
    student(Student, Course),
    frequents(Student, College).
 
% b)
college_personal(College, Person) :-
    employee(Person, College);
    frequents(Person, College).

% c)
colleague(X, Y) :-
    (frequents(X, College), frequents(Y,College);
    employee(X, College), employee(Y, College)),
    X \= Y.
