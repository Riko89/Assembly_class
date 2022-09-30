#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void initAuto(int pc_Board[10][10]);
void printBoardPC(int pc_Board[10][10]);
void initBoard(int player_Board[10][10], int ship);
void printBoard(int player_Board[10][10]);
int getGuess(int pc_Board[10][10]);
int pcGuess(int player_Board[10][10]);

int main(void) {
	srand(time(0));
	int player_Board[10][10];
	int pc_Board[10][10];
	int ships = 5, pcShips = 5;
	int carrier = 5, battleShip = 4, cruiser = 3, submarine = 3, patrol = 2; // c = 1, b = 2, sub = 4, cruis = 3, p = 5
	int pcC = 5, pcB = 4, pcR = 3, pcS = 3, pcD = 2;
	initAuto(pc_Board);
	printBoardPC(pc_Board);
	printf("Human init\n");
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 10; j++) {
			player_Board[i][j] = 6;
		}
	}
	// 1 == carrier, turn into loop increment
	for (int i = 1; i < 6; i++) {
		initBoard(player_Board, i);
		printBoard(player_Board);
	}
	int game = 1, hit = 0;

	while (game)
	{
		printf("Player One's Turn\n");
		hit = getGuess(pc_Board);
		if (hit != 0)
		{
			switch (hit)
			{
			case 1: pcC--;
				if (pcC == 0) {
					printf("PC Carrier Sunk!\n");
					pcShips--;
				}
				break;
			case 2: pcB--;
				if (pcB == 0) {
					printf("PC BattleShip sunk!\n");
					pcShips--;
				}
				break;
			case 3: pcR--;
				if (pcR == 0) {
					printf("PC cruiser sunk!\n");
					pcShips--;
				}
				break;
			case 4: pcS--;
				if (pcS == 0) {
					printf("PC sub sunk!\n");
					pcShips--;
				}
				break;
			case 5: pcD--;
				if (pcD == 0) {
					printf("PC destroyer sunk!\n");
					pcShips--;
				}
				break;
			}
		}
		printf("PC's Turn\n");
		hit = pcGuess(player_Board);
		if (hit != 0)
		{
			switch (hit)
			{
			case 1: carrier--;
				if (carrier == 0) {
					printf("Player Carrier Sunk!\n");
					ships--;
				}
				break;
			case 2: battleShip--;
				if (battleShip == 0) {
					printf("Player BattleShip sunk!\n");
					ships--;
				}
				break;
			case 3: cruiser--;
				if (cruiser == 0) {
					printf("Player cruiser sunk!\n");
					ships--;
				}
				break;
			case 4: submarine--;
				if (submarine == 0) {
					printf("Player sub sunk!\n");
					ships--;
				}
				break;
			case 5: submarine--;
				if (submarine == 0) {
					printf("Player destroyer sunk!\n");
					ships--;
				}
				break;
			}
		}
		printBoardPC(pc_Board);
		if (ships == 0)
		{
			printf("PC Wins\n");
			game = 0;
			break;
		}
		if (pcShips == 0)
		{
			printf("Player Wins\n");
			game = 0;
			break;
		}
	}
	return 0;
}

void initAuto(int pc_Board[10][10]) {
	for (int r = 0; r < 10; r++) {
		for (int c = 0; c < 10; c++) {
			pc_Board[r][c] = 6;
		}
	}
	int dir = 0; // 1 for down, 0 for right
	//int cpuGuess = 0; // oops, for later, wrong function
	int y = 0, x = 0, place = 0;
	//carrier = 1, battleShip = 2, cruiser = 3, submarine = 4, patrol = 5;
	int ship = 0; //starts with carrier
	
	place = 1;
	printf("Computer is placing ships..\n");
	while (place < 6) // place base case
	{
		switch (place)
		{
		case 1: ship = 5;
			printf("Placing Carrier...\n");
			break;
		case 2: ship = 4;
			printf("Placing battleship...\n");
			break;
		case 3: ship = 3;
			printf("Placing cruiser...\n");
			break;
		case 4: ship = 3;
			printf("Placing submarine...\n");
			break;
		case 5: ship = 2;
			printf("Placing Destroyer...\n");
			break;
		}
		dir = (rand() % 2); // down
		if (dir == 1)
		{
			x = (rand() % 10);
			do {
				y = (rand() % 10); // check for down
				for (int check = 0; check < ship; check++) {
					if (pc_Board[y + check][x] != 6) {
						y = 11;
						break;
					}
				}
			} while (!((y + (ship - 1)) < 10));
			for (int i = 0; i < ship; i++)
			{
				pc_Board[y + i][x] = place;
			}
		}
		else
		{
			y = (rand() % 10); //place right
			do {
				x = (rand() % 10);
				for (int check = 0; check < ship; check++) {
					if (pc_Board[y][x + check] != 6) {
						x = 11;
						break;
					}
				}
			} while (!((x + (ship - 1)) < 10));
			for (int i = 0; i < ship; i++)
			{
				pc_Board[y][x + i] = place;
			}
		}
		place++; // base case
	}
	printf("Finished placing ships - PC\n\n");
}
void printBoardPC(int pc_Board[10][10]) {
	printf("   0 1 2 3 4 5 6 7 8 9\n");
	for (int r = 0; r < 10; r++) {
		printf("%d  ", r);
		for (int c = 0; c < 10; c++) {
			switch (pc_Board[r][c]) {
			case 6: printf("-");
				break;
			case 7: printf("*");
				break;
			default: printf("-");
				break;
			}
			printf(" ");
		}
		printf("\n");
	}
}
void printBoard(int player_Board[10][10]) {
	printf("   0 1 2 3 4 5 6 7 8 9\n");
	for (int r = 0; r < 10; r++) {
		printf("%d  ", r);
		for (int c = 0; c < 10; c++) {
			switch (player_Board[r][c]) {
			case 1: printf("c");
				break;
			case 2: printf("b");
				break;
			case 3: printf("r");
				break;
			case 4: printf("s");
				break;
			case 5: printf("d");
				break;
			case 6: printf("-");
				break;
			case 7: printf("*");
				break;
			}
			printf(" ");
		}
		printf("\n");
	}
}
int pcGuess(int player_Board[10][10]) {
	srand(time(0));
	int x = 0, y = 0;
	do {
		x = (rand() % 10);
	} while (!(x > -1) && !(x < 10));
	do {
		y = (rand() % 10);
	} while (!(y > -1) && !(y < 10));
	int guess = player_Board[y][x];
	switch (guess) {
	case 1: printf("Hit!\n");
		return 1;
		break;
	case 2: printf("Hit!\n");
		return 2;
		break;
	case 3: printf("Hit!\n");
		return 3;
		break;
	case 4: printf("Hit!\n");
		return 4;
		break;
	case 5: printf("Hit!\n");
		return 5;
		break;
	default: printf("Miss!\n"); 
		return 0;
	}
}
