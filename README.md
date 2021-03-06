# A Technique to Detect Books from Library Bookshelf Image (2013)

This is the implementation of the paper A Technique to Detect Books from Library Bookshelf Image
by Mohammad Imrul Jubair and Prianka Banik. The paper was published in IEEE 9th International Conference on Computational Cybernetics, July 8-10, 2013, Tihany, Hungary.

![Alt text](https://github.com/imruljubair/A-Technique-to-Detect-Books-from-Library-Bookshelf-Image/blob/master/OUTPUT/screenshot.png)

link: https://ieeexplore.ieee.org/document/6617619/

# Author:

The code is written by Mohammad Imrul Jubair (author of the paper)

# How to run the code:

1. open and run the book_recogn.m
2. input images must be located inside INPUT folder.
3. OUTPUT folder contains all the results. There are sub folders - 
	a. SHELF: contains extracted shelves.
	b. DETECT: line detected as book boundary (shown as yellow lines) for each shelves.
	c. BOOKS: extracted books. There is a naming format for each images: shelfNumber_bookNumber.jpg. For example, 2_7.jpg means this is extracted from shelf no. 2, book number 7.

Note: Some sample input images are collected via google image searching. Another implementation can be found here: https://www.mathworks.com/matlabcentral/fileexchange/55134-a-technique-to-seperate-books-from-a-shelf-and-read-characters-from-it
