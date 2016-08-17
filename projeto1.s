# Code Quality Standards http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch07.html
# Please read:

# Default development language: English
# Commas are followed by a whitespace.
# Macros cannot be used in QtSpim.

#########################################################################
#   System call constants
#########################################################################

SYS_PRINT_INT       =   1
SYS_PRINT_FLOAT     =   2
SYS_PRINT_DOUBLE    =   3
SYS_PRINT_STRING    =   4
SYS_READ_INT        =   5
SYS_READ_FLOAT      =   6
SYS_READ_DOUBLE     =   7
SYS_READ_STRING     =   8
SYS_SBRK            =   9
SYS_EXIT            =   10
SYS_PRINT_CHAR      =   11
SYS_READ_CHAR       =   12

#########################################################################
#   Program defined constants
#########################################################################

STRUCT_TOTAL_SIZE   = 40
STRUCT_NAME_SIZE    = 16
MENU_STORE          = 1
MENU_DELETE         = 2
MENU_DISPLAY        = 3
MENU_CONSUMPTION    = 4
MENU_PRICE          = 5
MENU_RANKING        = 6

#########################################################################
#   Macro definitions and includes. See http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch09s03.html
#########################################################################

	# Print the string at address $var
	#.macro  print_string_var($var)
	#la      $a0, $var
	#li      $v0, SYS_PRINT_STRING
	#syscall
	#.end_macro

#########################################################################
#   Main program
#########################################################################

.data
# database
database:           .space 400

# messages
message_menu:       .asciiz "\n Escolha qual operacao realizar: \n \t 1-Armazenar \n \t 2-Excluir \n \t 3-Exibir \n \t 4-Exibir Consumo \n \t 5-Exibir Preco Medio \n \t 6-Exibir Ranking\n"
message_date:       .asciiz "\n Dia: "
message_slash:      .asciiz "\r/"
message_name:       .asciiz "\n Nome: "
message_kilometer:  .asciiz "\n Quilometragem: "
message_liters:     .asciiz "\n Quantidade: "
message_price:      .asciiz "\n Preco: "
message_invalid:    .asciiz "\n Valor invalido"

actionMessage_store:        .asciiz "\n Armazenar"
actionMessage_delete:       .asciiz "\n Excluir"
actionMessage_display:      .asciiz "\n Exibir"
actionMessage_consumption:  .asciiz "\n Consumo"
actionMessage_price:        .asciiz "\n Preco"
actionMessage_ranking:      .asciiz "\n Ranking"

.text
.globl main

main:
    add $s7, $zero, $zero	# Limpa o conteúdo do contador
    add $t0, $zero, $zero	# Limpa o conteúdo do t0
    add $t1, $zero, $zero	# Limpa o conteúdo do t1


menu:
    la $a0, message_menu
    jal displayMessage
    jal readInt
    
    beq $v0, MENU_STORE, store
    beq $v0, MENU_DELETE, delete
    beq $v0, MENU_DISPLAY, exibir
    beq $v0, MENU_CONSUMPTION, consumption
    beq $v0, MENU_PRICE, price
    beq $v0, MENU_RANKING, ranking

    la $a0, message_invalid
    jal displayMessage
    j menu


#########################################################################
#   Actions
#########################################################################

store:
    la $a0, actionMessage_store
    jal displayMessage
    
    la $a0, message_date
    jal displayMessage
    

    jal loadDatabase
    jal readInt
    sw  $v0, 0($t0)
    
    la $a0, message_slash
    jal displayMessage
    
    jal readInt
    la  $t0, database
    sw  $v0, 4($t0)
    
    la $a0, message_slash
    jal displayMessage
    
    jal readInt
    la  $t0, database
    sw  $v0, 8($t0)
    
    la $a0, message_name
    jal displayMessage
    
    la $a0, message_kilometer
    jal displayMessage
    
    la $a0, message_liters
    jal displayMessage
    
    la $a0, message_price
    jal displayMessage
    
    jr menu


delete:
    li $v0, 4
    la $a0, actionMessage_delete
    j menu
    #shift left 40 bits para excluir


exibir:
    li $v0, 4
    la $a0, actionMessage_display
    j menu


consumption:
    li $v0, 4
    la $a0, actionMessage_consumption
    j menu


price:
    li $v0, 4
    la $a0, actionMessage_price
    j menu


ranking:
    li $v0, 4
    la $a0, actionMessage_ranking
    j menu


#########################################################################
#   Helpers
#########################################################################

displayMessage:
    li $v0, SYS_PRINT_STRING
    syscall
    jr $ra


readInt:
    li $v0, SYS_READ_INT
    syscall
    jr $ra


readFloat:
    li $v0, SYS_READ_FLOAT
    syscall
    jr $ra


readDouble:
    li $v0, SYS_READ_DOUBLE
    syscall
    jr $ra


readName:
    li $v0, SYS_READ_STRING
    la $a0, buffer
    li $a1, STRUCT_NAME_SIZE
    add $v1, $a0, $zero
    jr $ra

    
loadDatabase:
    la $t0, database
    addi $t1, $zero, STRUCT_TOTAL_SIZE  #loads $t2 with STRUCT_TOTAL_SIZE
    mult $s7, $t1                       #multiplies counter*STRUCT_TOTAL_SIZE
    mflo $t2                            #
    add $v0, $t0, $t2
    jr $ra


#incrementRegister:
 #   lw $t0, $s7
  #  addi $t0, $t0, 1
   # sw $s7, $t0
    #jr $ra


#decrementRegister:
 #   lw $t0, $s7
  #  addi $t0, $t0, -1
   # sw $s7, $t0
    #jr $ra