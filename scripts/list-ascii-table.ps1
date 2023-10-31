﻿<#
.SYNOPSIS
        Lists the ASCII table
.DESCRIPTION
        This PowerShell script lists the ASCII table on the console.
.EXAMPLE
        PS> ./list-ascii-table.ps1

	Dec    Oct    Hex    HTML    Symbol     Description
	---    ---    ---    ----    ------     -----------
	  0    000     00    &#00;    NUL       Null character
        ...
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

""
"Dec    Oct    Hex     Binary     HTML    Symbol    Description"
"---    ---    ---     ------     ----    ------    -----------"
"  0    000     00    00000000    &#00;    NUL      Null character"
"  1    001     01    00000001    &#01;    SOH      Start of Header"
"  2    002     02    00000010    &#02;    STX      Start of Text"
"  3    003     03    00000011    &#03;    ETX      End of Text"
"  4    004     04    00000100    &#04;    EOT      End of Transmission"
"  5    005     05    00000101    &#05;    ENQ      Enquiry"
"  6    006     06    00000110    &#06;    ACK      Acknowledge"
"  7    007     07    00000111    &#07;    BEL      Bell"
"  8    010     08    00001000    &#08;    BS       Backspace"
"  9    011     09    00001001    &#09;    HT       Horizontal Tab"
" 10    012     0A    00001010    &#10;    LF       Line Feed"
" 11    013     0B    00001011    &#11;    VT       Vertical Tab"
" 12    014     0C    00001100    &#12;    FF       Form Feed"
" 13    015     0D    00001101    &#13;    CR       Carriage Return"
" 14    016     0E    00001110    &#14;    SO       Shift Out"
" 15    017     0F    00001111    &#15;    SI       Shift In"
" 16    020     10    00010000    &#16;    DLE      Data Link Escape"
" 17    021     11    00010001    &#17;    DC1      Device Control 1 (XON)"
" 18    022     12    00010010    &#18;    DC2      Device Control 2"
" 19    023     13    00010011    &#19;    DC3      Device Control 3 (XOFF)"
" 20    024     14    00010100    &#20;    DC4      Device Control 4"
" 21    025     15    00010101    &#21;    NAK      Negative Acknowledge"
" 22    026     16    00010110    &#22;    SYN      Synchronize"
" 23    027     17    00010111    &#23;    ETB      End of Transmission Block"
" 24    030     18    00011000    &#24;    CAN      Cancel"
" 25    031     19    00011001    &#25;    EM       End of Medium"
" 26    032     1A    00011010    &#26;    SUB      Substitute"
" 27    033     1B    00011011    &#27;    ESC      Escape"
" 28    034     1C    00011100    &#28;    FS       File Separator"
" 29    035     1D    00011101    &#29;    GS       Group Separator"
" 30    036     1E    00011110    &#30;    RS       Record Separator"
" 31    037     1F    00011111    &#31;    US       Unit Separator"
" 32    040     20    00100000    &#32;    space    Space"
" 33    041     21    00100001    &#33;    !        Exclamation mark"
" 34    042     22    00100010    &#34;    `"        Double quote"
" 35    043     23    00100011    &#35;    #        Number"
" 36    044     24    00100100    &#36;    $        Dollar sign"
" 37    045     25    00100101    &#37;    %        Percent"
" 38    046     26    00100110    &#38;    &        Ampersand"
" 39    047     27    00100111    &#39;    '        Single quote"
exit 0 # success