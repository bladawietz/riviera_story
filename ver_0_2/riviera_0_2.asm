/*
Riviera story engine
by Jaroslaw Popkowski
Fred/GDC

*/



BasicUpstart2(start)

//adresy pamięci komputera
.const SCREEN       =   $0400
.const COLOR_MAP    =   $d800  
.const VIC          =   $d000
.const CIA2         =   $dd00
.const JOY_2        =   $dc00

//adresy pamięci programu
.const sprite_memory    =   $2300 
.const char_memory      =   $2000
.const zmienne          =   $3000


.var sprite_data=LoadBinary("riviera_sprites_02.bin")
//.var sprite_data_attrib=LoadBinary("riviera_sprites_02_attr.bin")

.var level_1=LoadBinary("riviera_char_map_0_2.bin")
.var level_1_char=LoadBinary("riviera_char_0_2.bin")
.var level_1_char_color=LoadBinary("riviera_char_atrib_0_2.bin")
 
.var sciezka_1_1=LoadBinary("sciezka_1_1.bin")
.var sciezka_1_2=LoadBinary("sciezka_1_2.bin")
.var sciezka_1_3=LoadBinary("sciezka_1_3.bin")
//.var char_data=LoadBinary("")
// Próba kompilacji
// 
    *=$c000
start:
    jsr initialize
    jsr copyScreen    


main_loop:
   
    //ruszają się wrogowie!!!!!
    //trzeba ich opoznić
    ldx sciezka_1_1_opoznienie1
    cpx sciezka_1_1_op_max
    bne pomin_wroga_1
    ldx #$00
    stx sciezka_1_1_opoznienie1
    
    
    ldx sciezka_1_1_indeks
    cpx sciezka_1_1_dl
    bcc wrog_1_ruch  
   
    ldx #$00
    stx sciezka_1_1_indeks
    lda sciezka_1_1_kierunek
    eor #$01                    //zmiana kieunku - negacja
    sta sciezka_1_1_kierunek

wrog_1_ruch:

    lda sciezka_1_1_kierunek
    cmp #$00   // ruszamy się zgodnie ze ścieżką
    beq normalny_indeks
    //dlugosc-1-index
    clc
    lda sciezka_1_1_dl
    sbc sciezka_1_1_indeks
    tax
    dex
normalny_indeks:
    lda sciezka_1_1_data,x
    sta wrog_1_x
    inx
    lda sciezka_1_1_data,x
    sta wrog_1_y
    inc sciezka_1_1_indeks
    inc sciezka_1_1_indeks
//    jmp pomin_wroga_1
    
   //jsr colison_det    
   //jsr ruch 
   // lda chck+$0d
   // sta $0400
pomin_wroga_1:
    inc sciezka_1_1_opoznienie1
    inc wrog_1_frame
    
//wróg nr 2

    ldx sciezka_1_2_opoznienie1
    cpx sciezka_1_2_op_max
    bne pomin_wroga_2
    ldx #$00
    stx sciezka_1_2_opoznienie1
    
    
    ldx sciezka_1_2_indeks
    cpx sciezka_1_2_dl
    bcc wrog_2_ruch  
   
    ldx #$00
    stx sciezka_1_2_indeks
 //   lda sciezka_1_2_kierunek
 //   eor #$01                    //zmiana kieunku - negacja
 //   sta sciezka_1_2_kierunek

wrog_2_ruch:

//    lda sciezka_1_1_kierunek
//    cmp #$00   // ruszamy się zgodnie ze ścieżką
//    beq normalny_indeks
    //dlugosc-1-index
//    clc
//    lda sciezka_1_1_dl
//    sbc sciezka_1_1_indeks
//    tax
//    dex
normalny_indeks2:
    lda sciezka_1_2_data,x
    sta wrog_2_x
    inx
    lda sciezka_1_2_data,x
    sta wrog_2_y
    inc sciezka_1_2_indeks
    inc sciezka_1_2_indeks
//    jmp pomin_wroga_2

pomin_wroga_2:
    inc sciezka_1_2_opoznienie1
    inc wrog_2_frame


// wróg nr 3
    ldx sciezka_1_3_opoznienie1
    cpx sciezka_1_3_op_max
    bne pomin_wroga_3
    ldx #$00
    stx sciezka_1_3_opoznienie1
    
    
    ldx sciezka_1_3_indeks
    cpx sciezka_1_3_dl
    bcc wrog_3_ruch  
   
    ldx #$00
    stx sciezka_1_3_indeks
    lda sciezka_1_3_kierunek
    eor #$01                    //zmiana kieunku - negacja
    sta sciezka_1_3_kierunek

wrog_3_ruch:
    lda sciezka_1_3_kierunek
    cmp #$00   // ruszamy się zgodnie ze ścieżką
    beq normalny_indeks3
    //dlugosc-1-index
    clc
    lda sciezka_1_3_dl
    sbc sciezka_1_3_indeks
    tax
    dex
normalny_indeks3:
    lda sciezka_1_3_data,x
    sta wrog_3_x
    inx
    lda sciezka_1_3_data,x
    sta wrog_3_y
    inc sciezka_1_3_indeks
    inc sciezka_1_3_indeks
//    jmp pomin_wroga_1
    
   //jsr colison_det    
   //jsr ruch 
   // lda chck+$0d
   // sta $0400
pomin_wroga_3:
    inc sciezka_1_3_opoznienie1
    inc wrog_3_frame

// wróg nr 4

    ldx wrog_4_opoznienie
    cpx wrog_4_opoznienie_max
    bne pomin_wroga_4
    ldx #$00
    stx wrog_4_opoznienie
// śledzenie ludzika
    ldx ludzik_x
    cpx wrog_4_x
    bcc odejmij_x_4
    inc wrog_4_x
    jmp pomin_wroga_4y
odejmij_x_4:
    dec wrog_4_x

pomin_wroga_4y:
    ldx ludzik_y
    cpx wrog_4_y
    bcc odejmij_y_4
    inc wrog_4_y
    jmp pomin_wroga_4
odejmij_y_4:
    dec wrog_4_y

pomin_wroga_4:
    inc wrog_4_opoznienie
    inc wrog_4_frame


// wróg nr 5

    ldx wrog_5_opoznienie
    cpx wrog_5_opoznienie_max
    bne pomin_wroga_5
    ldx #$00
    stx wrog_5_opoznienie

// śledzenie ludzika
    ldx ludzik_x
    cpx wrog_5_x
    bcc odejmij_x_5
    inc wrog_5_x
    jmp pomin_wroga_5y
odejmij_x_5:
    dec wrog_5_x

pomin_wroga_5y:
    ldx ludzik_y
    cpx wrog_5_y
    bcc odejmij_y_5
    inc wrog_5_y
    jmp pomin_wroga_5
odejmij_y_5:
    dec wrog_5_y

pomin_wroga_5:
    inc wrog_5_opoznienie
    inc wrog_5_frame

// koniec wrogów
    // odczyt pozycji joysticka
    lda JOY_2
    and #%00000100 //3 bit -lewo
    bne nie_lewo
    // czy był wcześniej ruch w lewo???
    lda ludzik_kierunek
    cmp #$00
    beq kontynuuj_lewo
    //zmiana kierunku
    lda #$00
    sta ludzik_kierunek
    sta ludzik_frame
    jsr przepisz_sprite
kontynuuj_lewo:
    lda ludzik_x 
    cmp #$1c
    beq nie_lewo
    
    dec ludzik_x
    inc ludzik_frame
    jsr ruch

nie_lewo:
    lda JOY_2
    and #%00001000 //4 bit -prawo
    bne nie_prawo
    // czy był wcześniej ruch w prawo???
    lda ludzik_kierunek
    cmp #$02
    beq kontynuuj_prawo
    //zmiana kierunku
    lda #$02
    sta ludzik_kierunek
    lda #$00
    sta ludzik_frame
    jsr przepisz_sprite

kontynuuj_prawo:
/*

//    //czy ludzik_x = $ff
    //jaki jest stan bitu VIC+16
    lda VIC+16
    and #$01
    bne jest_po_lewej
// jesteśmy po prawej stronie ekranu



jest_po_lewej:
    lda ludzik_x
    cmp #$ff
    bne dodaj_x
    lda VIC+16
    ora #$01
    sta VIC+16
    lda #$00
    sta ludzik_x 
*/
dodaj_x:
    lda ludzik_x
    cmp #$fc
    beq nie_prawo
    inc ludzik_x
    inc ludzik_frame
    jsr ruch

nie_prawo:

    lda JOY_2
    and #%00010000 //5 bit -fire
    bne nie_fire 
    lda chck+$0a
    cmp #$00        //czy jest coś pod nogami?
    beq nie_fire
    
    lda jump
    cmp #$00        //00 - nie jest w trakcie skoku
    bne nie_fire
    
    // zaczynamy skok
    lda #$01        //01 - do góry
    sta jump
    lda #$00
    sta jump+1      //zerowanie aktualnej wysokości skoku


nie_fire:

/*
    lda JOY_2
    and #%00000010 //1 bit -dół
    bne nie_dol
    inc ludzik_y
    inc ludzik_frame
//    jsr ruch
nie_dol:
    
    lda JOY_2
    and #%00000001 //1 bit -dół
    bne nie_gora
    dec ludzik_y
    inc ludzik_frame
//    jsr ruch
nie_gora:
*/
    
//obsługa skoku
    //lda jump
    //sta $d020 
    //lda chck+$0c
    //sta $0400
    
    lda jump
    cmp #$00      //brak skoku
    beq nie_ma_skoku
        
    
    cmp #$01       //do góry
    bne zawis

wznoszenie:
    //lda jump
    //sta $d020 
    //lda chck+$0d  // co nad głową?
    //sta $0400
    
    lda ludzik_y
    cmp #$3a
    bcc nie_odejmuj
    dec ludzik_y
 nie_odejmuj:
    inc jump+1
    lda jump+1
    cmp jump+2
    bne nie_ma_skoku
    lda #$02      //przejscie do zawisu
    sta jump
    lda #$00
    sta jump+1
    jmp nie_ma_skoku
zawis:
    //lda jump
    //sta $d020 
    
    lda jump
    cmp #$02
    bne spadanie
    inc jump+1
    lda jump+1
    cmp jump+3
    bne nie_ma_skoku
    lda #$03      //przejscie do spadania
    sta jump
    lda #$00
    sta jump+1
    jmp nie_ma_skoku
spadanie:
    
    //lda jump
    //sta $d020 
    
    inc ludzik_y
    inc jump+1
    lda jump+1
    cmp jump+2
    bne nie_ma_skoku
    lda #$00      //koniec skoku
    sta jump
    lda #$00
    sta jump+1

nie_ma_skoku:    
    lda chck+$0a
    cmp #$01
    beq cos_pod_nogami
    cmp #$08
    beq cos_pod_nogami


    lda jump
    cmp #$0
    bne wykrycia //koniec_ruchu
    inc ludzik_y
    jmp wykrycia //koniec_ruchu




cos_pod_nogami:
    //tu będzie procedura reagowania
    // czy to było w trakcie opadania???
    lda jump
    cmp #$03
    bne wykrycia
    // na coś upadliśmy podczas opadania
    // kończymy skok
    lda #$00
    sta jump
    sta jump+1
    
wykrycia:
    lda VIC+31
    //sta $0429+$28
    and #$01   //sprawdzamy tylko 1 sprajta
    beq koniec_ruchu
    
    
    //jak gdzieś jest #$02 to śmierć
    ldx #$00
wykr:
    //inc $d020
    lda chck+2,x
    //sta $0429,x
    cmp #$02
    beq smierc
    cmp #$03
    beq smierc
    cmp #$04
    beq smierc
    inx
    cpx #$09
    bne wykr 

koniec_ruchu:    
    //sprawdzamy kolizję spriteów
    lda VIC+$1e
//    sta $0400
    and #$01
    cmp #$01
    beq smierc

    jsr ruch



 
    //czekaj do końca ramki
    wait:
        lda VIC+18
        cmp #$32
        bne wait

    
    jmp main_loop
 
//endless_loop:
//    jmp endless_loop
    
smierc:
//    lda #$00
//    sta VIC
    

    
    ldx #$ff
pauza:    
    inc $d020
    ldy #$ff
pauza2:
    dey
    bne pauza2
    dex
    bne pauza


    //lda #$00    
    //sta VIC+$15
    //lda VIC+$1e
    //sta $0400
    
    
joy_smierc:
    lda JOY_2
    and #%00010000 //5 bit -fire
    bne joy_smierc 
    
    
    ldy #$ff
pauza_pauza_1:
    dey
    bne pauza_pauza_1

joy_fire_tak:
    lda JOY_2
    and #%00010000
    beq joy_fire_tak

 //resetuj pozycje śledzących wrogów
 //f4 38 20 38
    lda #$f4
    sta wrog_4_x
    lda #$38
    sta wrog_4_y
    lda #$20
    sta wrog_5_x
    lda #$38
    sta wrog_5_y
       
    
    
    
    jmp start
    


przepisz_sprite:

    lda #$8c
    clc
    adc ludzik_kierunek
    adc ludzik_frame_nr
    sta SCREEN+1016
rts

przepisz_sprite_wrog1:

    lda #$90
    clc
    adc wrog_1_frame_nr
    sta SCREEN+1017
rts

przepisz_sprite_wrog2:

    lda #$92
    clc
    adc wrog_2_frame_nr
    sta SCREEN+1018
rts

przepisz_sprite_wrog3:

    lda #$98
    clc
    adc wrog_3_frame_nr
    sta SCREEN+1021
rts

przepisz_sprite_wrog4:

    lda #$94
    clc
    adc wrog_4_frame_nr
    sta SCREEN+1019
rts

przepisz_sprite_wrog5:

    lda #$96
    clc
    adc wrog_5_frame_nr
    sta SCREEN+1020
rts




ruch:
    
    lda ludzik_frame
    cmp #$08    //skok animacji
    bne wrog_anim1
    
    
    lda #$00 
    sta ludzik_frame
    lda ludzik_frame_nr // negacja nr. klatki
    eor #$01
    sta ludzik_frame_nr
    jsr przepisz_sprite

wrog_anim1:

    lda wrog_1_frame
    cmp #$0e    //skok animacji
    bne wrog_anim2
    
    
    lda #$00 
    sta wrog_1_frame
    lda wrog_1_frame_nr // negacja nr. klatki
    eor #$01
    sta wrog_1_frame_nr
    jsr przepisz_sprite_wrog1

wrog_anim2:

    lda wrog_2_frame
    cmp #$1e    //skok animacji
    bne wrog_anim3
    
    
    lda #$00 
    sta wrog_2_frame
    lda wrog_2_frame_nr // negacja nr. klatki
    eor #$01
    sta wrog_2_frame_nr
    jsr przepisz_sprite_wrog2

wrog_anim3:

    lda wrog_3_frame
    cmp #$1e    //skok animacji
    bne wrog_anim4
    
    
    lda #$00 
    sta wrog_3_frame
    lda wrog_3_frame_nr // negacja nr. klatki
    eor #$01
    sta wrog_3_frame_nr
    jsr przepisz_sprite_wrog3

wrog_anim4:

    lda wrog_4_frame
    cmp #$1e    //skok animacji
    bne wrog_anim5
    
    
    lda #$00 
    sta wrog_4_frame
    lda wrog_4_frame_nr // negacja nr. klatki
    eor #$01
    sta wrog_4_frame_nr
    jsr przepisz_sprite_wrog4

wrog_anim5:

    lda wrog_5_frame
    cmp #$1e    //skok animacji
    bne skip_anim
    
    
    lda #$00 
    sta wrog_5_frame
    lda wrog_5_frame_nr // negacja nr. klatki
    eor #$01
    sta wrog_5_frame_nr
    jsr przepisz_sprite_wrog5


skip_anim:
    lda ludzik_x
    sta VIC 
    lda ludzik_y
    clc
    sbc #$01      //korekta położenia
    sta VIC+1
    
    lda wrog_1_x
    sta VIC+2
    lda wrog_1_y
    sta VIC+3
    
    lda wrog_2_x
    sta VIC+4
    lda wrog_2_y
    sta VIC+5
    
    lda wrog_3_x
    sta VIC+10
    lda wrog_3_y
    sta VIC+11

    lda wrog_4_x
    sta VIC+6
    lda wrog_4_y
    sta VIC+7

    lda wrog_5_x
    sta VIC+8
    lda wrog_5_y
    sta VIC+9

    jsr colison_det
    rts

colison_det:
    //wpisywanie w ciąg bajtów o adresie początkowym chck:
    //chck+0 : odpowiadający wiersz
    //chck+1 : odpowiadająca kolumna
    //chck+2 : wartość o współrzędnych 0,0
    //chck+3 : wartość o współrzędnych 0,1
    //chck+4 : wartość o współrzędnych 0,2
    //chck+5 : wartość o współrzędnych 0,3
    //chck+6 : wartość o współrzędnych 1,0 
    //chck+7 : wartość o współrzędnych 1,1    
    //chck+8 : wartość o współrzędnych 1,2 
    //chck+9 : wartość o współrzędnych 1,3
    //chck+a : chck+5 or chck+9 (pod nogami)
   

    //chck+a - to jest pod ludzikiem, jeśli coś jest to tu zapala się:
    //00 - nic nie ma
    //01 - można chodzić
    //02 - inne - zgon
    lda #$00
    sta chck+$0a
        
    //na razie wpisujemy wartości do komórki chck,chck+1
    lda ludzik_x
    clc 
    sbc  #$10//#$18-8    // ustalono eksperymentalnie
    lsr 
    lsr 
    lsr         //podzielić przez 8
    sta chck
    lda ludzik_y
    clc
    sbc #$32    //  ustalono eksperymentalnie
    lsr 
    lsr 
    lsr         //podzielić przez 8
    sta chck+1
    
    
    
odczyt:
    //odczyt z komórki 1024+($2021)*40+($2020)
    //po bólach i męce stworzona przez J.P.
    //procedura korzysta z 2 bajtów na stronie zerowej $fb i $fc
    // wpisujemy adres 1024 na strone zerową

    lda #$00
    sta $fb
    lda #$04
    sta $fc
    // pobieramy wartość kolumny
    ldy chck+1
kolumna:
    cpy #$00
    beq koniec_kolumny
    lda #$28 
    sta $fd
    jsr dodaj
    dey
    jmp kolumna

koniec_kolumny:
    ldx #$00
petla_odczytu:

    ldy chck
    lda ($fb),y
    sta chck+2,x       // <-w tej komorce jest wartosc tla pod spodem
// debug  
//    lda #$04
//    sta ($fb),y

    iny
    lda ($fb),y
    sta chck+6,x       // <-w tej komorce jest wartosc tla pod spodem

// debug  
//    lda #$04
//    sta ($fb),y

    lda #$28            //następna kolumna
    sta $fd
    jsr dodaj
    
    inx
    cpx #$04
    bne petla_odczytu

//jeśli któryś ze znaków ma wartość ze zmiennej podłoga
// to ustaw je na $01    
    
    ldx #$00
spr_podlogi:
    lda chck+$05
    cmp podloga,x
    bne spr_dalej1
    lda #$01
    sta chck+$05
spr_dalej1:
    lda chck+$09
    cmp podloga,x
    bne spr_dalej2
    lda #$01
    sta chck+$09
spr_dalej2:
    inx
    cpx #$03
    bne spr_podlogi


    lda #$00
    ora chck+$05
    ora chck+$09
    sta chck+$0a //pod nogami
    


rts

dodaj:
// procedura dodająca do adresu zapisanego w komórkach $fb (LSB) i $fc (MSB) wartość przesunięcia $fd
    lda $fb  //bierzemy LSB
    clc
    adc $fd  //dodajemy wartość zapisaną w $fd
    sta $fb
    bcc koniec_dodawania    //jak nie ma przepełnienia to kończymy
    clc                     //jak jest przepełnienie to zwiększamy MSB+1
    inc $fc
koniec_dodawania:
    
    rts
    

initialize:
    //ustawienia ekranu
    // SCREEN -> pamięc ekranu
    // char_memory  -> pamięć znaków
    lda VIC+$18
    and #%11110001
    ora #%00001000
    sta VIC+$18
        
    //ustawienia sprite
    //blok pamięci dla sprite 
    //sprite 0 - ma 4 klatki
    lda #$8c
    sta SCREEN+1016
    //pozostałe mają 2 klatki animacji

    ldx #$90
    ldy #$00

 przypisz_bloki:   
    txa
    sta SCREEN+1017,y
    inx
    inx 
    iny
    cpy #$05
    bne przypisz_bloki

    
    //tryb wielobarwny
    lda VIC+$1c    
    ora #%00111111
    sta VIC+$1c

    //kolory:
    lda #$02 //czerwony
    sta VIC+37 // kolor 0 (wszystkie)
    lda #$06 //niebieski
    sta VIC+38 // kolor 1 (wszystkie)
    
    ldx #$00
petla_kolorow:
    lda sprite_colors,x
    sta VIC+39,x // kolor duszka 0
    inx
    cpx #$06
    bne petla_kolorow

    //ustawiamy tryb wielokolorowy
    lda VIC+$16
    ora #$10
    sta VIC+$16

    //współrzędne x i y
    lda #$80
    sta ludzik_x
    lda #$72 
    sta ludzik_y

    jsr ruch
    
    //aktywacja duszków  - ludzik i 5 wrogów
    lda VIC+$15
    ora #%00111111
    sta VIC+$15

    //kolory ramki i tła
    lda #$00
    sta VIC+$020
    lda #$ff
    sta VIC+$021
    //kolory trybu multicolor dla znaków
    lda #$07 // żółty dla 01
    sta VIC+$22
    lda #$02 // czerwony dla 11
    sta VIC+$23

    lda VIC+$1e   //wyczyść dane o kolizjach    
    
    //debug
    //pokaz duszki

    ldx #$00
petla_duszkow:
    lda dane_chwilowe,x
    sta VIC+4,x
    inx
    cpx #$08
    bne petla_duszkow
    
    rts
    
dane_chwilowe:
    .byte 40,80,40,120,40,160,40,200
    

// kopiowanie danych do pamięci ekranu
copyScreen:
    ldx #$00
    copy255:
        lda level_memory,x
        sta SCREEN,x
        tay
        lda level_color_map,y
        sta COLOR_MAP,x
        lda level_memory+$100,x
        sta SCREEN+$100,x
        tay
        lda level_color_map,y
        sta COLOR_MAP+$100,x
        lda level_memory+$200,x
        sta SCREEN+$200,x
        tay
        lda level_color_map,y
        sta COLOR_MAP+$200,x
        // nie można wjechać poza pamięć ekranu!!
        cpx #$e8
        bcs not_copy
        lda level_memory+$300,x
        sta SCREEN+$300,x
        tay
        lda level_color_map,y
        sta COLOR_MAP+$300,x
        
    not_copy:
        inx
        bne copy255
    rts


// dane
// pamięc ekranu - level 1



// zdefiniowane znaki

    *=char_memory "znaki własne"

.fill level_1_char.getSize(), level_1_char.get(i)


    *=zmienne "zmienne"
chck: //   0   1   2   3   4   5   6   7   8   9   a    b  c   d
    .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

level_memory:
.fill level_1.getSize(), level_1.get(i)

level_color_map:
.fill level_1_char_color.getSize(), level_1_char_color.get(i)
podloga:    //które znaki są podłogą oprócz $01???
    .byte $08,$34,$35

ludzik_x:
    .byte $80
ludzik_y:
    .byte $40
ludzik_frame:
    .byte $00
ludzik_frame_nr:
    .byte $00
ludzik_kierunek:
    .byte $00 //0 -lewo, 2 - prawo

wrog_1_x:
    .byte $ff
wrog_1_y:
    .byte $50
wrog_1_frame:
    .byte $00
wrog_1_frame_nr:
    .byte $00

wrog_2_x:
    .byte $ff
wrog_2_y:
    .byte $50
wrog_2_frame:
    .byte $00
wrog_2_frame_nr:
    .byte $00

wrog_3_x:
    .byte $ff
wrog_3_y:
    .byte $50
wrog_3_frame:
    .byte $00
wrog_3_frame_nr:
    .byte $00

wrog_4_x:
    .byte $f4
wrog_4_y:
    .byte $38
wrog_4_frame:
    .byte $00
wrog_4_frame_nr:
    .byte $00
wrog_4_opoznienie:
    .byte $00
wrog_4_opoznienie_max:
    .byte $0c

wrog_5_x:
    .byte $20
wrog_5_y:
    .byte $38
wrog_5_frame:
    .byte $00
wrog_5_frame_nr:
    .byte $00
wrog_5_opoznienie:
    .byte $00
wrog_5_opoznienie_max:
    .byte $0c


jump: //   0   1   2   3   4   5   6   7     
    .byte $00,$00,$20,$05
    // 0 - czy jest skok
    // 1 - aktualny skok
    // 2 - max wysokosc skoku
    // 3 - czas zwisu
sciezka_1_1_data:
    .fill sciezka_1_1.getSize(), sciezka_1_1.get(i)
sciezka_1_1_dl:  
    .byte sciezka_1_1.getSize()
sciezka_1_1_indeks:
    .byte 0 
sciezka_1_1_opoznienie1:
    .byte $00 
sciezka_1_1_kierunek:
    .byte $00 // 0 - rosnąca, 1 malejąca
sciezka_1_1_op_max:
    .byte $0a

sciezka_1_2_data:
    .fill sciezka_1_2.getSize(), sciezka_1_2.get(i)
sciezka_1_2_dl:  
    .byte sciezka_1_2.getSize()
sciezka_1_2_indeks:
    .byte 0 
sciezka_1_2_opoznienie1:
    .byte $00 
sciezka_1_2_kierunek:
    .byte $00 // 0 - rosnąca, 1 malejąca
sciezka_1_2_op_max:
    .byte $0a    

sciezka_1_3_data:
    .fill sciezka_1_3.getSize(), sciezka_1_3.get(i)
sciezka_1_3_dl:  
    .byte sciezka_1_3.getSize()
sciezka_1_3_indeks:
    .byte 0 
sciezka_1_3_opoznienie1:
    .byte $00 
sciezka_1_3_kierunek:
    .byte $00 // 0 - rosnąca, 1 malejąca
sciezka_1_3_op_max:
    .byte $0a    
   
  *=sprite_memory "dane sprite"

sprite:
    .fill sprite_data.getSize(), sprite_data.get(i)
sprite_colors:
    .byte $0a,$0e,$00,$00,$0c,$01
