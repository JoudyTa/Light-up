cls :-write('\e[2J').
% todo: R1 
% مشروع
size(8,8).

wall(1,6).
wall(2,2).
wall(2,3).
wall(3,7).
wall(4,1).
wall(4,5).
wall(5,4).
wall(5,8).
wall(6,2).
wall(7,6).
wall(7,7).
wall(8,3).


wallnum(1,6,1).
wallnum(2,2,3).
wallnum(3,7,0).
wallnum(5,4,4).
wallnum(5,8,0).
wallnum(6,2,2).
wallnum(7,6,1).


light(1,2).
light(1,7).
light(2,1).
light(2,8).
light(3,2).
light(4,4).
light(4,6).
light(5,3).
light(5,5).
light(6,1).
light(6,4).
light(7,2).
light(7,8).
light(8,6).

% todo: R2 

% im2
% size(7,7).

% wall(1,2).
% wall(2,7).
% wall(3,3).
% wall(3,5).
% wall(4,4).
% wall(5,3).
% wall(5,5).
% wall(6,1).
% wall(7,6).


% wallnum(1,2,0).
% wallnum(2,7,2).
% wallnum(3,3,4).
% wallnum(3,5,2).
% wallnum(5,3,3).
% wallnum(6,1,1).



% todo: R3


% size(7,7).

% wall(1,1).
% wall(1,4).
% wall(1,7).
% wall(2,5).
% wall(3,2).
% wall(4,1).
% wall(4,7).
% wall(5,6).
% wall(6,3).
% wall(7,1).
% wall(7,4).
% wall(7,7).


% wallnum(1,4,1).
% wallnum(1,7,1).
% wallnum(2,5,2).
% wallnum(4,1,1).
% wallnum(5,6,2).
% wallnum(7,1,0).
% wallnum(7,4,1).
% wallnum(7,7,1).

% todo: R4


% size(10,10).

% wall(1,2).
% wall(1,3).
% wall(1,5).

% wall(2,3).
% wall(2,6).
% wall(2,10).

% wall(3,9).
% wall(3,10).

% wall(4,4).
% wall(4,7).

% wall(5,2).
% wall(5,10).

% wall(6,1).
% wall(6,9).

% wall(7,4).
% wall(7,7).

% wall(8,1).
% wall(8,2).

% wall(9,1).
% wall(9,5).
% wall(9,8).

% wall(10,6).
% wall(10,8).
% wall(10,9).
% % 

% wallnum(1,2,1).
% wallnum(1,3,0).
% wallnum(2,3,0).
% wallnum(2,10,2).
% wallnum(4,7,3).
% wallnum(6,9,0).
% wallnum(7,4,3).
% wallnum(8,2,2).
% wallnum(10,6,2).
% wallnum(10,9,1).

:- dynamic light/2.
:- dynamic x/2.

cell(X,Y):-size(R,C) ,X>0,X<(R+1),Y>0,Y<(C+1).

not_wall(X,Y):- not(wall(X,Y)).
not_cell(X,Y):- not(cell(X,Y)).
%! A  ===========================================================================
%! 1  ===========================================================================
neighbor(X,Y,NX,Y):-NX is X-1,cell(NX,Y),not_wall(NX,Y) .

neighbor(X,Y,NX,Y):-NX is X+1,cell(NX,Y),not_wall(NX,Y) .

neighbor(X,Y,X,NY) :-NY is Y-1,cell(X,NY),not_wall(X,NY) .

neighbor(X,Y,X,NY) :-NY is Y+1,cell(X,NY),not_wall(X,NY) .

neighbors_cell(X,Y,L) :-findall(neighbor(NX,NY),neighbor(X,Y,NX,NY),L).


% !2 Column  ===========================================================================

neighbor_column_R(X,Y,[]):-wall(X,Y),!.
neighbor_column_R(X,Y,[cel(X,Y)|T]):- cell(X,Y),NX is X+1,neighbor_column_R(NX,Y,T),!.
neighbor_column_R(X,Y,[]):-not_cell(X,Y),!.

neighbors_columns_R(X,Y,L):-NX is X+1,neighbor_column_R(NX,Y,L).


neighbor_column_L(X,Y,[]):-wall(X,Y),!.
neighbor_column_L(X,Y,[cel(X,Y)|T]):- cell(X,Y),NX is X-1,neighbor_column_L(NX,Y,T),!.
neighbor_column_L(X,Y,[]):-not_cell(X,Y),!.
neighbors_columns_L(X,Y,L):-NX is X-1,neighbor_column_L(NX,Y,L).

neighbors_columns(X,Y,L):-neighbors_columns_L(X,Y,LL),neighbors_columns_R(X,Y,LR),append(LL,LR,L).

% !2 Row ===========================================================================
neighbor_row_R(X,Y,[]):-wall(X,Y),!.
neighbor_row_R(X,Y,[cel(X,Y)|T]):- cell(X,Y),NY is Y+1,neighbor_row_R(X,NY,T),!.
neighbor_row_R(X,Y,[]):-not_cell(X,Y),!.
neighbors_rows_R(X,Y,L):-NY is Y+1,neighbor_row_R(X,NY,L).

neighbor_row_L(X,Y,[]):-wall(X,Y),!.
neighbor_row_L(X,Y,[cel(X,Y)|T]):- cell(X,Y),NY is Y-1,neighbor_row_L(X,NY,T),!.
neighbor_row_L(X,Y,[]):-not_cell(X,Y),!.
neighbors_rows_L(X,Y,L):-NY is Y-1,neighbor_row_L(X,NY,L).

neighbors_rows(X,Y,L):-neighbors_rows_L(X,Y,LL),neighbors_rows_R(X,Y,LR),append(LL,LR,L).

get_neighbors_Col_Row(X,Y,L):-neighbors_columns(X,Y,LC),neighbors_rows(X,Y,LR), append(LR, LC, L).

% ?test ---------------------------
% guilty(Guilty):-
%     member(Guilty, [ahmad, bassel, camal, dan]),
%     (Guilty = ahmad -> Ahmad =1; Ahmad =0),
%     (Guilty = dan  -> Bassel =1; Bassel =0),
%     (Guilty = bassel  -> Camal =1; Camal =0),
%     (Guilty \= dan -> Dan =1; Dan = 0),
%     Ahmad + Bassel + Camal +Dan =:= 1, !.
% ?test ---------------------------

%* Help ??????????????????????????


% !3  Number of light cell  ===========================================================================
findx_y(C,XC,YC):-C=cel(XC,YC).
light_cell([], []).
light_cell([H|T], TL) :- findx_y(H,XC,YC) ,not(light(XC,YC)), light_cell(T, TL),!.
light_cell([H|T], [HL|TL]) :-findx_y(H,XC,YC) ,light(XC,YC), HL is 1, light_cell(T, TL),!.

num_light_cell(X,Y,Len):- get_neighbors_Col_Row(X,Y,L),light_cell(L,LLi),length(LLi,Len).

% 

% ?test 1 ---------------------------
% nnn(XC,YC,X,Len):-write('nnn 1 _ '),light(XC,YC),write('nnn 2 _ '), X is [1|T].
% nn(L,X,Len):-write('nn 1 _ '), member(Find, L),write('nn 2 _ '),f(Find,XC,YC),write('nn 3 _ '),nnn(XC,YC,X,Len),write('nn 4 _ '),write('nn 5 _ ').
% % nn([cel(1,2),cel(1,1),cel(1,7)],X).
% n(X,Y,LR,LC,L):- neighbors_columns(X,Y,LR),neighbors_rows(X,Y,LC), append(LR, LC, L),length(L,Len),nn(L,X,Len).
% ?test 1 ---------------------------
 
% ?test 2 ---------------------------
% nn([], 0).
% nn([H|_],1,Len) :-f(H,XC,YC) ,light(XC,YC),Len is Len-1. % get_empty_cells(T, EmptyCells),!.
% nn([_|T], X,Len):- nn(T, X1,Len), X is len .
% ?test 2 ---------------------------

% !4 Cell is Light  ===========================================================================
is_cell_light(X,Y):-num_light_cell(X,Y,Len),Len >0.

% !5 Wall cell = cell nagbor ===========================================================================
neighbor_islight(X,Y,NX,Y):-NX is X-1,light(NX,Y).

neighbor_islight(X,Y,NX,Y):-NX is X+1,light(NX,Y).

neighbor_islight(X,Y,X,NY) :-NY is Y-1,light(X,NY).

neighbor_islight(X,Y,X,NY) :-NY is Y+1,light(X,NY).

neighbors_wall_num(X,Y,Len):-findall(p(NX,NY),neighbor_islight(X,Y,NX,NY),L),length(L,Len).
neighbors_wall_num_is_E_light(X,Y):-neighbors_wall_num(X,Y,Len) ,wallnum(X,Y,N),Len=N.




% ?----------------------------------------

% n:- neighbors_rows(X,Y,LR),neighbors_columns(X,Y,LC), append(LR, LC, L)
% 0
% get_a_cell(Row,Col) :- get_row(Row), get_col(Col).
% n:-findall(cell(Row,Col), get_a_cell(Row,Col), Empty_Board). 




%? ----------------------------------------
% n(L,Len):-findall(cel(X,Y),wall(X,Y),L),length(L,Len), member(element,L),findx_y(element,XC,YC),neighbors_cell(XC,YC,L).
% nn(L,LL):-findall(cel(NX,NY),(write('0'),member(Element,L),write('1'),findx_y(Element,XC,YC),write('2'),neighbor(XC,YC,NX,NY),write('3')),LL).


%! جميع الخلايا مضائة==============================================


% ? get All  Cell 
get_row(E,E,E):-!.
get_row(B,E,B):- B<E.
get_row(B,E,X):-B1 is B+1,get_row(B1,E,X).

get_col(E,E,E):-!.
get_col(B,E,B):- B<E.
get_col(B,E,X):-B1 is B+1,get_col(B1,E,X).

get_a_cell(L):-size(R,C) ,findall(cel(Row,Col),(get_row(1,R,Row), get_col(1,C,Col)),L).

% ?check

check_cell_light([]).
check_cell_light([H|T]):- findx_y(H,XC,YC),light(XC,YC),check_cell_light(T),!.
check_cell_light([H|T]):-findx_y(H,XC,YC),is_cell_light(XC,YC),check_cell_light(T),!.


lighted_cells_all:-get_a_cell(L),check_cell_light(L).
 


%! خلاليا المصباح ليست مضائة من قبل مصباح اخر ==============================================


%? get All  Cell light

get_a_cell_light(L):-size(R,C),findall(cel(Row,Col),(get_row(1,R,Row), get_col(1,C,Col),light(Row,Col)),L).


% ?check

check_cell_no_double_light([]).
check_cell_no_double_light([H|T]):-findx_y(H,XC,YC),not(is_cell_light(XC,YC)),check_cell_no_double_light(T).

no_double_light:-get_a_cell_light(L),check_cell_no_double_light(L).

% ! عدد خلايا المصباح المحيطة بجميع خلايا الحائط المرقمة==============================================

%? get All  Cell wall

get_a_cell_wallnum(L):-size(R,C),findall(cel(Row,Col),(get_row(1,R,Row), get_col(1,C,Col),wallnum(Row,Col,_)),L).


% ?check

check_cell_wallnum([]).
check_cell_wallnum([H|T]):-findx_y(H,XC,YC),neighbors_wall_num_is_E_light(XC,YC),check_cell_wallnum(T),!.

light_count_correct:-get_a_cell_wallnum(L),check_cell_wallnum(L).

%! solved =========================================================================
solved:-lighted_cells_all,no_double_light,light_count_correct.


% !print grid===========================================================================

print_row(X):-size(_,C),get_col(1,C,Y),
(
    wallnum(X,Y,N)->format('~w~w  ~w ' ,['B',N,'']);(
        wall(X,Y)->format('~w~w  ~w ',['B','-','']);(
            light(X,Y)->format('~w~w  ~w ',['L','-','']);( is_cell_light(X,Y)->format('~w~w  ~w ',['D','-','']))
        ;format('~w~w  ~w ',['E','-',''])
                )
                )
                ),fail.
print_grid:-size(R,_),get_row(1,R,X),nl,\+print_row(X),fail.
print:- \+print_grid.
%! clear All assert ========================================================================

clear_row(X):-size(_,C),get_col(1,C,Y),
(light(X,Y)->retract(light(X,Y))),(x(X,Y)->retract(x(X,Y))),fail.
clear_grid:-size(R,_),get_row(1,R,X),\+clear_row(X),fail.
retractall:- \+clear_grid.

clear_rowx(X):-size(_,C),get_col(1,C,Y),
(x(X,Y)->retract(x(X,Y))),fail.
clear_gridx:-size(R,_),get_row(1,R,X),\+clear_rowx(X),fail.
retractallx:- \+clear_gridx.


clear:- retractall,retractallx.

% ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
%!chek is light count neighbor no more Num wall ========================================================================

neighbors_wall_num_no_more_light(X,Y):- findall(p(NX,NY),neighbor_islight(X,Y,NX,NY),L),length(L,Len),wallnum(X,Y,N),Len=< N.

% ?check

check_cell_wallnum_no_more([]).
check_cell_wallnum_no_more([H|T]):-findx_y(H,XC,YC),neighbors_wall_num_no_more_light(XC,YC),check_cell_wallnum_no_more(T),!.


light_count_no_more_wallnum:-get_a_cell_wallnum(L),check_cell_wallnum_no_more(L).

%!  play ======================================================================== 

% ?Chake insert 
insert(X,Y):- light(X,Y),write('\nnxxxxxxxxxxxxxxxxxxxxxxxxxxxxx    Incorrect entry. Enter again    xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n') ,play,!.
insert(X,Y):-wall(X,Y),write('Enter an error, enter again ') ,play,!.
insert(X,Y):- \+light(X,Y),not_wall(X,Y) ,assert(light(X,Y)),!.

% ?solved play win and do you play agin 

play:-solved,print,write('\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  You Win  xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n\n'),write('Do You Play Again [y/n] ? '),read(Answer),(Answer ='y'->retractall,play ;!).

% ?play  
play:- print,write('\n\nEnter XPosition ? '), 
              read(XPosition),write('Enter YPosition ? '),read(YPosition),
              insert(XPosition,YPosition),(no_double_light,light_count_no_more_wallnum->play;play_again).
          
% ?you lost and  play agin 

play_again:-write('\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  Game Over play again    xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n\n'),retractall,play.

% ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????


% ! play auato=============================================================================================
% *insert
insert_light_auto(X,Y):- \+light(X,Y),not_wall(X,Y), assert(light(X,Y)),!.
insert_light_auto(_,_).
insert_x_auto(X,Y):- \+x(X,Y),not_wall(X,Y) ,assert(x(X,Y)),!.
insert_x_auto(_,_).

% todo: Strategies 1
neighbor_Empty_cell(X,Y,NX,Y):-NX is X-1,cell(NX,Y),not_wall(NX,Y),not(light(NX,Y)),not(is_cell_light(NX,Y)),not(x(NX,Y)).

neighbor_Empty_cell(X,Y,NX,Y):-NX is X+1,cell(NX,Y),not_wall(NX,Y),not(light(NX,Y)),not(is_cell_light(NX,Y)),not(x(NX,Y)).

neighbor_Empty_cell(X,Y,X,NY) :-NY is Y-1,cell(X,NY),not_wall(X,NY),not(light(X,NY)),not(is_cell_light(X,NY)),not(x(X,NY)).

neighbor_Empty_cell(X,Y,X,NY) :-NY is Y+1,cell(X,NY),not_wall(X,NY),not(light(X,NY)),not(is_cell_light(X,NY)),not(x(X,NY)).

% ?
neighbor_isx(X,Y,NX,Y):-NX is X-1,x(NX,Y).

neighbor_isx(X,Y,NX,Y):-NX is X+1,x(NX,Y).

neighbor_isx(X,Y,X,NY) :-NY is Y-1,x(X,NY).

neighbor_isx(X,Y,X,NY) :-NY is Y+1,x(X,NY).

neighbors_wall_num_X(X,Y,Len):-findall(p(NX,NY),neighbor_isx(X,Y,NX,NY),L),length(L,Len).
% 

insert_light_in_fullwall(L):-member(Element,L),findx_y(Element,XC,XY),assert(light(XC,XY)),write(light(XC,XY)),print,sleep(0.5),nl,nl,!,
full_wall_num_E_empty.

% ?  تاكد اذا كانت يمكن وضع ضوء حول الحائط
chack_light_in_fullwall(X,Y):- findall(cel(NX,NY),neighbor_Empty_cell(X,Y,NX,NY),L),length(L,Len),neighbors_wall_num(X,Y,Lenlight),
wallnum(X,Y,N),NewN is(N-Lenlight),(NewN=Len ->insert_light_in_fullwall(L)).

% ?
full_wall_num_E_empty:-write('full_wall_num_E_empty'),nl,get_a_cell_wallnum(L),member(Element,L),findx_y(Element,XC,XY),chack_light_in_fullwall(XC,XY),fail.


% todo: Strategies 2
% neighbors_wall_num(X,Y,Len):-findall(p(NX,NY),neighbor_islight(X,Y,NX,NY),L),length(L,Len).
% neighbors_wall_num_is_E_light(X,Y):-neighbors_wall_num(X,Y,Len) ,wallnum(X,Y,N),Len=N.
% ?cell_is_wall_zero and insert x cell
neighbor_wall_zero(X,Y,NX,Y):-NX is X-1,cell(NX,Y),wallnum(NX,Y,0).

neighbor_wall_zero(X,Y,NX,Y):-NX is X+1,cell(NX,Y),wallnum(NX,Y,0).

neighbor_wall_zero(X,Y,X,NY) :-NY is Y-1,cell(X,NY),wallnum(X,NY,0).

neighbor_wall_zero(X,Y,X,NY) :-NY is Y+1,cell(X,NY),wallnum(X,NY,0).

cell_is_wall_zero(X,Y) :-findall(cel(NX,NY),neighbor_wall_zero(X,Y,NX,NY),L),length(L,Len),Len>0,assert(x(X,Y)).



% ?cell_is_wall_zero and insert x cell

neighbor_wall_full(X,Y,NX,Y):-NX is X-1,cell(NX,Y),wallnum(NX,Y,_),neighbors_wall_num_is_E_light(NX,Y).

neighbor_wall_full(X,Y,NX,Y):-NX is X+1,cell(NX,Y),wallnum(NX,Y,_),neighbors_wall_num_is_E_light(NX,Y).

neighbor_wall_full(X,Y,X,NY) :-NY is Y-1,cell(X,NY),wallnum(X,NY,_),neighbors_wall_num_is_E_light(X,NY).

neighbor_wall_full(X,Y,X,NY) :-NY is Y+1,cell(X,NY),wallnum(X,NY,_),neighbors_wall_num_is_E_light(X,NY).

cell_is_wall_full(X,Y) :-findall(cel(NX,NY),neighbor_wall_full(X,Y,NX,NY),L),length(L,Len),Len>0,assert(x(X,Y)).

% 

empty_cell_is_only([]).
empty_cell_is_only([H|T]):- findx_y(H,XC,YC),x(XC,YC),empty_cell_is_only(T),!.
empty_cell_is_only([H|T]):- findx_y(H,XC,YC),light(XC,YC),empty_cell_is_only(T),!.
empty_cell_is_only([H|T]):-findx_y(H,XC,YC),is_cell_light(XC,YC),empty_cell_is_only(T),!.



% Get Empty Cell
get_a_cell_Empty(L):-size(R,C),findall(cel(Row,Col),(get_row(1,R,Row), get_col(1,C,Col),not(wall(Row,Col)),not(light(Row,Col)),
not(is_cell_light(Row,Col)),not(cell_is_wall_zero(Row,Col)),not(cell_is_wall_full(Row,Col)) ),L).

% 
put_light_in_empty_cell_canput:-write('put_light_in_empty_cell_canput'),nl,get_a_cell_Empty(L),member(Element,L),findx_y(Element,XC,YC),get_neighbors_Col_Row(XC,YC,LCel),
(empty_cell_is_only(LCel)->assert(light(XC,YC)),write(light(XC,YC)),print,nl,nl,
sleep(0.5),!,\+full_wall_num_E_empty,put_light_in_empty_cell_canput).

% todo: Strategies 3

put_empty_L2:-get_a_cell_Empty(L),put_empty_L1(L).

put_empty_L1([]).
put_empty_L1([H|T]):-findx_y(H,XC,YC),assert(light(XC,YC)),write(light(XC,YC)),print,nl,nl,sleep(0.5),put_empty_L2,
(not(solved)->assert(x(XC,YC)),retract(light(XC,YC)),write(delete(XC,YC)),nl,put_empty_L1(T)).

put_in_empty_cell_Retr:-write('put_in_empty_cell_Retr'),nl ,get_a_cell_Empty(L),put_empty_L1(L).

% put_in_empty_cell-retrograde(L):-get_a_cell_Empty(L),member(Element,L),findx_y(Element,XC,YC),assert(light(XC,YC)),print,nl,
% sleep(0.5),length(L,LL),(LL>0 ->write('2'),!,put_in_empty_cell(_);(LL=0,not(solved)->assert(x(XC,YC)),retract(light(XC,YC)),write('1'),!,put_in_empty_cell(_))) .%,!,put_in_empty_cell.%,\+full_wall_num_E_empty,\+put_light_in_empty_cell_canput.

% cel(1, 7), cel(1, 8), cel(2, 5), cel(2, 6), cel(2, 8), cel(4, 6)
play_a:-clear, \+full_wall_num_E_empty,\+put_light_in_empty_cell_canput,\+put_in_empty_cell_Retr.

% clear
% neighbor_ce(X,Y,NX,Y):-NX is X-1,light(NX,Y),.

% neighbor_ce(X,Y,NX,Y):-NX is X+1,light(NX,Y).

% neighbor_ce(X,Y,X,NY) :-NY is Y-1,light(X,NY).

% neighbor_ce(X,Y,X,NY) :-NY is Y+1,light(X,NY).

w(X,Y,Len):-findall(p(NX,NY),neighbor_Empty_cell(X,Y,NX,NY),L),length(L,Len).
% ?
put_X(X,Y):-NX is X-1,NY is Y-1,cell(NX,NY),not_wall(NX,NY),not(light(NX,NY)),not(wall(NX,NY)),assert(x(NX,NY)),write(1).

put_X(X,Y):-NX is X-1,NY is Y+1 ,cell(NX,NY),not_wall(NX,NY),not(light(NX,NY)),not(wall(NX,NY)),assert(x(NX,NY)),write(2).

put_X(X,Y) :-NX is X+1, NY is Y-1,cell(NX,NY),not_wall(NX,NY),not(light(NX,NY)),not(wall(NX,NY)),assert(x(NX,NY)),write(3).

put_X(X,Y) :-NX is X+1,NY is Y+1,cell(NX,NY),not_wall(NX,NY),not(light(NX,NY)),not(wall(NX,NY)),assert(x(NX,NY)),write(4).

% get_X(X,Y):-findall(cel(X,Y),put_X(X,Y),L),insert_X(L),!,put_x_edge.
% insert_X(L):-member(Element,L),findx_y(Element,XC,XY),assert(x(XC,XY)).
% a(X,Y,N):-N=4,put_X(X,Y),!,put_x_edge.
% a(X,Y,N):-N=3,put_X(X,Y),!,put_x_edge.
% a(X,Y,N):-N\=0 ,neighbors_wall_num(XC,YC,LenLight),NNew is N-LenLight ,w(XC,YC,LenW),LenW=<NNew+1,put_X(X,Y),!,put_x_edge.

put_x_edge:-get_a_cell_wallnum(L),member(Element,L),findx_y(Element,XC,YC),wallnum(XC,YC,N),%a(XC,YC,N),fail.
(wallnum(XC,YC,N) ,N=4 -> put_X(XC,YC);%,!,put_x_edge;
    (wallnum(XC,YC,N) ,N=3   -> put_X(XC,YC);%,!,put_x_edge; 
        (wallnum(XC,YC,N) ,N\=0,neighbors_wall_num(XC,YC,LenLight),NNew is N-LenLight ,w(XC,YC,LenW),LenW=<NNew+1 ->put_X(XC,YC)%,!,put_x_edge
        )
        )
        ),fail.

r(X):-size(_,C),get_col(1,C,Y),
(
    wallnum(X,Y,N)->format('~w~w  ~w ' ,['B',N,'']);(
        wall(X,Y)->format('~w~w  ~w ',['B','-','']);(
            light(X,Y)->format('~w~w  ~w ',['L','-','']);(x(X,Y)->format('~w~w  ~w ',['x','-','']))
        ;format('~w~w  ~w ',['E','-',''])
                )
                )
                ),fail.
rr:-size(R,_),get_row(1,R,X),nl,\+r(X),fail.
p:- \+rr.

% pwd.
% working_directory(CWD,'C:/Users/zayan/Desktop').
% pwd.
% [ligthup].
% play.
% play_a.