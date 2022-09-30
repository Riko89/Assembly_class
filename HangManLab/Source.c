#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <ctype.h>

int contains(char line[], char *guess);
int main() {
	FILE * fp;
	fp = fopen("dictionary.txt", "r");
	if (!fp) {
		printf("Cannot find file to open\n");
		return 1;
	}
	int correct[15];
	char line[15];
	char guess = '0';
	int itterations = 0;
	char *hangMan = "Hangman";
	int size = 0;
	int win = 0;
	while (!feof(fp)) {
		printf("Starting Hangman, guess the word one character at a time, 1 to quit\n");
		for (int i = 0; i < 14; i++) {
			line[i] = '\0';
			correct[i] = 0;
		}
		fgets(line, 15, fp);
		size = 0;
		for (int i = 0; i < sizeof(line)-1; i++)
		{
			if (isalpha(line[i])) {
				size++;
			}
		}
		win = 0;
		itterations = 0;
		while (win != size) {
			for (int i = 0; i < size; i++)
			{
				if (correct[i] == 1)
					printf(" %c ", line[i]);
				else
					printf(" - ");
			}
			printf("\n");
			for(int i = 0; i < itterations; i++)
			{
				printf("%c", hangMan[i]);
			}
			for (int i = 0; i < 7 - itterations; i++) {
				printf(" - ");
			}
			printf("\n");
			fseek(stdin, 0, SEEK_END);
			scanf("%c", &guess);
			if (guess == '1') {
				fclose(fp);
				return 1;
			}
			if (contains(line, guess) >= 0) {
				correct[contains(line, guess)] = 1;
				win++;
				itterations--;
			}
			else
				printf("BUZZ!\n");
			if (win == size) {
				printf("%s\n", line);
				printf("You win!\n");
				break;
			}
			else if (itterations == 6) {
				printf("Hangman!");
				break;
			}
			itterations++;
		}
	}
	fclose(fp);
	return 0;
}

int contains(char line[], char *guess) {
	for (int i = 0; i < sizeof(line); i++){
		if (line[i] == guess) {
			return i;
		}
	}
	return -1;
}