;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;  C A S S E T T E   T A P E   R O U T I N E S
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;
;  PZLOAD: Game Restore Function
;
PZLOAD  BSR     FILNAM          ;get the file name
        DEC     ZFLAG           ;flag for load
        RTS                     ;bye
;
FILNAM  LDX     #TOKEN          ;initialize TOKEN buffer
        LEAU    32,X            ;negative ones
        SWI                     ;   .
        FCB     NEGRAM          ;   .
        JMP     GETTOK          ;grab the next token/exit
;
;  PZSAVE: Game Restore Function
;
PZSAVE  BSR     FILNAM          ;get the file name
        STX     >$007E          ;set buffer addr
        LDD     #$000F          ;BLKTYP,,BLKLEN  (0=namefile,,15=length)
        STD     >$007C          ;   .
;
;  Set up NAMEFILE Block:
;       Bytes   Description
;       0-7     Program Name
;       8       File Type (0=BASIC, 1=DATA, 2=Machine Language)
;       9       ASCII Flag (0=Binary, -1=ASCII)
;       10      Gap Flag (1=continuous, -1=gaps)
;       11-12   Start Addr of Machine Language Program
;       13-14   Load Addr of Machine Language Program
;
;       LDA     #2              ;file type = machine language
;       STA     8,X             ;   .
;       CLR     9,X             ;ASCII flag = Binary
;
        INC     ZFLAG           ;flag for save
        RTS                     ;bye
;
;;;;;        END
