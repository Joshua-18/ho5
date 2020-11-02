SQL> @ C:\Users\Joshua\Documents\itse1345\competency_3\competency3_2\ho5\Ho#5.sql
SQL> -- Joshua Membreno
SQL> 
SQL> -- #5-1
SQL> CREATE OR REPLACE 
  2  PROCEDURE prod_name_sp
  3    (p_prodid IN bb_product.idproduct%TYPE,
  4     p_descrip IN bb_product.description%TYPE)
  5    IS
  6  BEGIN
  7    UPDATE bb_product
  8      SET description = p_descrip
  9      WHERE idproduct = p_prodid;
 10    COMMIT;
 11  END;
 12  /

Procedure PROD_NAME_SP compiled

SQL> BEGIN
  2  prod_name_sp(1,'CapressoBar Model #388');
  3  END;
  4  /

PL/SQL procedure successfully completed.

SQL> SELECT *
  2    FROM bb_product;

                                       HO5-JOSHUA MEMBRENO                                        
   ID PROD             PROD        SALE  SALE   SALE             FEATURE  FEATURE        ID               
 PROD NAME  DESC       IMAGE PRICE START END   PRICE ACTIVE FEATURED START  END  TYPE   DEP ST ORDER REORD
----- ----- ---------- ----- ----- ----- ----- ----- ----- ----- -- -- -- ----- -- ----- -----
    1 Capre CapressoBa capre 99.99                       1             E      2 23     0    12
      ssoBa r Model #3 sso.g                                                                  
      r Mod 88         if                                                                     
      el #3                                                                                   
      51                                                                                      

    2 Capre Coffee and capre 129.99                       1             E      2 15     0     9
      sso U  Espresso  sso2.                                                                  
      ltima and Cappuc gif                                                                    
            cino Machi                                                                        
            ne. Brews                                                                         
            from one e                                                                        
            spresso to                                                                        
             two six o                                                                        
            unce cups                                                                         
            of coffee                                                                         

    3 Eilee A unique c frepr  32.5                       1             E      2 30     0    15
      n 4-c offeemaker ess.g                                                                  
      up Fr  from thos if                                                                     
      ench  e proud cr                                                                        
      Press aftsmen in                                                                        
             windy Nor                                                                        
            mandy.                                                                            

    4 Coffe Avoid blad grind  28.5                       1             E      2 26     0    25
      e Gri e grinders .gif                                                                   
      nder  ! This mil                                                                        
            l grinder                                                                         
            allows you                                                                        
             to choose                                                                        
             a fine gr                                                                        
            ind to a c                                                                        
            oarse grin                                                                        
            d.                                                                                

    5 Sumat Spicy and  sumat  10.5                       1             C      1 41     0    45
      ra    intense wi ra.jp                                                                  
            th herbal  g                                                                      
            aroma.                                                                            

    6 Guata heavy body Guata    10 01-JU 15-JU     8     1             C      1 42     0    35
      mala  , spicy tw mala.       N-12  N-12                                                 
            ist, aroma jpg                                                                    
            tic and sm                                                                        
            okey flavo                                                                        
            r.                                                                                

    7 Colum dry, nutty colum  10.8                       1             C      1 61     0    35
      bia    flavor an bia.j                                                                  
            d smoothne pg                                                                     
            ss                                                                                

    8 Brazi well-balan brazi  10.8                       1             C      1 53     0    35
      l     ced mellow l.jpg                                                                  
             flavor, a                                                                        
             medium bo                                                                        
            dy with hi                                                                        
            nts of coc                                                                        
            oa and a m                                                                        
            ild, nut-l                                                                        
            ike aftert                                                                        
            aste                                                                              

    9 Ethio distinctiv ethio    10                       1             C      1 54     0    35
      pia   e berry-li pia.j                                                                  
            ke flavor  pg                                                                     
            and aroma,                                                                        
             reminds m                                                                        
            any of a f                                                                        
            ruity, mem                                                                        
            orable win                                                                        
            e.                                                                                

   10 Espre dense, car espre    10                       1             C      1 50    50    50
      sso   amel-like  sso.j                                                                  
            sweetness  pg                                                                     
            with a sof                                                                        
            t acidity.                                                                        
             Roasted s                                                                        
            omewhat da                                                                        
            rker than                                                                         
            traditiona                                                                        
            l Italian.                                                                        

   68 Roast Well-balan roast   9.5                       1                                    
      ed Bl ced mix of ed.jp                                                                  
      end    roasted b g                                                                      
            eans, medi                                                                        
            um body                                                                           


11 rows selected. 

SQL> /
SQL> -- #5-2
SQL> CREATE OR REPLACE 
  2  PROCEDURE PROD_ADD_SP 
  3  (p_name IN bb_product.productname%TYPE,
  4   p_descrip IN bb_product.description%TYPE,
  5   p_image IN bb_product.productimage%TYPE,
  6   p_price IN bb_product.price%TYPE,
  7   p_active_st IN bb_product.active%TYPE)
  8   AS 
  9  BEGIN
 10    INSERT INTO bb_product
 11     (idproduct, productname, description, productimage, price, active)
 12    VALUES
 13     (BB_PRODID_SEQ.nextval,p_name, p_descrip, p_image, p_price, p_active_st);
 14     COMMIT;
 15  END PROD_ADD_SP;
 16  /

Procedure PROD_ADD_SP compiled

SQL> DELETE FROM bb_product WHERE
  2  productname = 'Roasted Blend';

1 row deleted.

SQL> COMMIT;

Commit complete.

SQL> /
SQL> BEGIN
  2  prod_add_sp('Roasted Blend','Well-balanced mix of roasted beans, medium body',
  3  'roasted.jpg', 9.50, 1);
  4  END;
  5  /

PL/SQL procedure successfully completed.

SQL> SELECT *
  2  FROM bb_product
  3  WHERE productname = 'Roasted Blend';

                                       HO5-JOSHUA MEMBRENO                                        
   ID PROD             PROD        SALE  SALE   SALE             FEATURE  FEATURE        ID               
 PROD NAME  DESC       IMAGE PRICE START END   PRICE ACTIVE FEATURED START  END  TYPE   DEP ST ORDER REORD
----- ----- ---------- ----- ----- ----- ----- ----- ----- ----- -- -- -- ----- -- ----- -----
   69 Roast Well-balan roast   9.5                       1                                    
      ed Bl ced mix of ed.jp                                                                  
      end    roasted b g                                                                      
            eans, medi                                                                        
            um body                                                                           


SQL> /
SQL> -- #5-3
SQL> CREATE OR REPLACE 
  2  PROCEDURE TAX_COST_SP 
  3  (p_state IN bb_tax.state%TYPE,
  4   p_subtot IN bb_basket.subtotal%TYPE,
  5   p_taxes OUT NUMBER)
  6  AS 
  7      lv_taxes bb_tax.taxrate%TYPE;
  8  BEGIN
  9    SELECT taxrate * p_subtot
 10    INTO lv_taxes
 11    FROM bb_tax
 12    WHERE state = p_state;
 13  
 14    IF lv_taxes IS NULL THEN
 15      p_taxes := 0;
 16    ELSE 
 17      p_taxes := lv_taxes;
 18    END IF;
 19  
 20  END TAX_COST_SP;
 21  /

Procedure TAX_COST_SP compiled

SQL> DECLARE 
  2      lv_taxes NUMBER(7,2);
  3  BEGIN
  4      TAX_COST_SP('VA',100,lv_taxes);
  5  DBMS_OUTPUT.PUT_LINE('Your taxes are:'|| TO_CHAR(lv_taxes, '$999.99'));
  6  END;
  7  /
Your taxes are:   $4.50


PL/SQL procedure successfully completed.

SQL> -- #5-4
SQL> DELETE FROM bb_basketitem WHERE
  2      idbasketitem = 44;

1 row deleted.

SQL> DELETE FROM bb_basketitem WHERE
  2      idbasketitem = 45;

1 row deleted.

SQL> DELETE FROM bb_basket WHERE
  2      idbasket = 17;

1 row deleted.

SQL> CREATE OR REPLACE PROCEDURE BASKET_CONFIRM_SP 
  2  (p_idbask    IN  bb_basket.idbasket%TYPE,
  3   p_subtotal  IN  bb_basket.subtotal%TYPE,
  4   p_shipping  IN  bb_basket.shipping%TYPE,
  5   p_tax       IN  bb_basket.tax%TYPE,
  6   p_total     IN  bb_basket.total%TYPE
  7   )
  8  IS 
  9  BEGIN
 10    UPDATE bb_basket
 11      SET subtotal = p_subtotal,
 12          shipping = p_shipping,
 13          tax = p_tax,
 14          total = p_total,
 15          orderplaced = 1
 16      WHERE idbasket = p_idbask;
 17      COMMIT;
 18  END BASKET_CONFIRM_SP;
 19  /

Procedure BASKET_CONFIRM_SP compiled

SQL> INSERT ALL 
  2      INTO bb_basket (idbasket, quantity, idshopper, orderplaced, subtotal,
  3                         total, shipping, tax, dtcreated, promo)
  4         VALUES (17,2,22,0,0,0,0,0,'28-FEB-12',0) 
  5  
  6      INTO bb_basketitem (idbasketitem, idproduct, price, quantity, idbasket,
  7                             option1, option2)
  8         VALUES (44,7,10.8,3,17,2,3)
  9      INTO bb_basketitem (idbasketitem, idproduct, price, quantity, idbasket,
 10                             option1, option2)
 11         VALUES (45,8,10.8,3,17,2,3)
 12      SELECT * FROM DUAL;

3 rows inserted.

SQL> COMMIT;

Commit complete.

SQL> /
SQL> BEGIN 
  2      basket_confirm_sp(17,64.80,8.00,1.94,74.74);
  3  END;
  4  /

PL/SQL procedure successfully completed.

SQL> SELECT subtotal, shipping, tax, total, orderplaced
  2  FROM bb_basket
  3  WHERE idbasket = 17;

                                       HO5-JOSHUA MEMBRENO                                        
  SUBTOTAL   SHIPPING        TAX      TOTAL ORDERPLACED
---------- ---------- ---------- ---------- -----------
      64.8          8       1.94      74.74           1

SQL> /
SQL> -- # 5-5
SQL> CREATE OR REPLACE 
  2  PROCEDURE STATUS_SHIP_SP
  3  (p_baskid   IN  bb_basketstatus.idbasket%TYPE,
  4   p_date     IN  DATE,
  5   p_shipp    IN  bb_basketstatus.shipper%TYPE,
  6   p_shippnum IN  bb_basketstatus.shippingnum%TYPE)
  7  AS 
  8  BEGIN
  9    INSERT INTO bb_basketstatus (idstatus, idbasket, idstage, dtstage, 
 10              shipper, shippingnum)
 11      VALUES (bb_status_seq.nextval, p_baskid, 3, p_date, p_shipp, p_shippnum);
 12    commit;
 13  END STATUS_SHIP_SP;
 14  /

Procedure STATUS_SHIP_SP compiled

SQL> BEGIN
  2      STATUS_SHIP_SP(3, '20-FEB-12', 'UPS', 'ZW2384YXK4957');
  3  END;
  4  /

PL/SQL procedure successfully completed.

SQL> SELECT idstatus, idbasket, idstage, dtstage, shipper, shippingnum
  2  FROM bb_basketstatus;

                                       HO5-JOSHUA MEMBRENO                                        
  IDSTATUS   IDBASKET    IDSTAGE DTSTAGE   SHIPP SHIPPINGNUM         
---------- ---------- ---------- --------- ----- --------------------
         1          3          1 24-JAN-12                           
         2          3          5 25-JAN-12 UPS   ZW845584GD89H569    
         3          4          1 13-FEB-12                           
         4          4          5 14-FEB-12                           
        15         12          3                                     
        16          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        17          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        18          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        19          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        20          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        21          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        22          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        23          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        24          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        25          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        26          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        27          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        28          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        29          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        30          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        31          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        32          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        33          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        34          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        35          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        36          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        37          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        38          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        39          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        40          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        41          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        42          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        43          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        44          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        45          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        46          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        47          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        48          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        49          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        50          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        51          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        52          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        53          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        54          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        55          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        56          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        57          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        58          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        59          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        60          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        61          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        62          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        63          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        64          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        65          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        66          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        67          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        68          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        69          3          3 20-FEB-12 UPS   ZW2384YXK4957       
        70          3          3 20-FEB-12 UPS   ZW2384YXK4957       

60 rows selected. 

SQL> /
SQL> -- # 5-6
SQL> CREATE OR REPLACE 
  2  PROCEDURE STATUS_SP 
  3  (p_basketid     IN  bb_basketstatus.idbasket%TYPE,
  4   p_date         OUT bb_basketstatus.dtstage%TYPE,
  5   p_descr        OUT bb_basketstatus.notes%TYPE)
  6  AS
  7  lv_stage bb_basketstatus.idstage%TYPE;
  8  CURSOR cur_stat IS
  9  SELECT idstage, dtstage
 10    INTO lv_stage, p_date  
 11    FROM bb_basketstatus
 12    WHERE idbasket = p_basketid
 13    ORDER BY dtstage DESC;
 14  BEGIN
 15    OPEN cur_stat;
 16    FETCH cur_stat INTO lv_stage, p_date;
 17    CASE lv_stage
 18      WHEN 1 THEN p_descr := 'Submitted and received';
 19      WHEN 2 THEN p_descr := 'Confirmed, processed, sent to shipping';
 20      WHEN 3 THEN p_descr := 'Shipped';
 21      WHEN 4 THEN p_descr := 'Cancelled';
 22      WHEN 5 THEN p_descr := 'Back-ordered';
 23      ELSE p_descr := 'Status not availiable.';
 24    END CASE;
 25  END STATUS_SP;
 26  /

Procedure STATUS_SP compiled

SQL> DECLARE
  2      lv_date DATE;
  3      lv_desc VARCHAR2(50);
  4  BEGIN
  5      STATUS_SP(4,lv_date, lv_desc);
  6      DBMS_OUTPUT.PUT_LINE(lv_date);
  7      DBMS_OUTPUT.PUT_LINE(lv_desc);
  8  --    DBMS_OUTPUT.PUT_LINE('');
  9      STATUS_SP(6,lv_date, lv_desc);
 10      DBMS_OUTPUT.PUT_LINE(lv_date);
 11      DBMS_OUTPUT.PUT_LINE(lv_desc);
 12  END;
 13  /
14-FEB-12
Back-ordered

Status not availiable.


PL/SQL procedure successfully completed.

SQL> -- #5-7
SQL> DELETE FROM bb_promolist WHERE
  2      year = 2012;

2 rows deleted.

SQL> CREATE OR REPLACE 
  2  PROCEDURE PROMO_SHIP_SP
  3  (p_date     IN  DATE,
  4   p_month    IN  bb_promolist.month%TYPE,
  5   p_year     IN  bb_promolist.year%TYPE)
  6  AS
  7  lv_minim          bb_basket.idshopper%TYPE;
  8  lv_maxim          bb_basket.idshopper%TYPE;
  9  lv_date         bb_basket.dtcreated%TYPE;
 10  lv_shopp      bb_basket.idshopper%TYPE;
 11  lv_prom_flag    NUMBER;
 12  BEGIN
 13    SELECT min(idshopper), max(idshopper)
 14    INTO lv_minim, lv_maxim
 15    FROM bb_basket;
 16  
 17    FOR i IN lv_minim .. lv_maxim LOOP
 18    SELECT max(dtcreated)
 19    INTO lv_date
 20    FROM bb_basket
 21    WHERE idshopper = i;
 22  
 23       IF p_date >= lv_date THEN
 24           SELECT count(idshopper)
 25           INTO lv_prom_flag
 26           FROM bb_promolist
 27           WHERE i = idshopper;
 28  
 29           IF lv_prom_flag = 1 THEN CONTINUE;
 30           ELSE 
 31              INSERT INTO bb_promolist (idshopper, month, year, promo_flag, used)
 32              VALUES(i, p_month, p_year, 1, 'N');
 33           END IF;
 34       END IF;
 35    END LOOP;
 36  COMMIT;
 37  END PROMO_SHIP_SP;
 38  /

Procedure PROMO_SHIP_SP compiled

SQL> BEGIN
  2      PROMO_SHIP_SP('15-FEB-12', 'APR', 2012);
  3  END;
  4  /

PL/SQL procedure successfully completed.

SQL> SELECT *
  2  FROM bb_promolist;

                                       HO5-JOSHUA MEMBRENO                                        
                      PROM       
 IDSHOPPER MONTH YEAR FLAG  USED 
---------- ----- ---- ----- -----
        21 APR   2012 1     N    
        26 APR   2012 1     N    

SQL> /
SQL> -- # 5-8
SQL> CREATE OR REPLACE 
  2  PROCEDURE BASKET_ADD_SP 
  3  (p_baskid    IN bb_basketitem.idbasket%TYPE,
  4   p_produid   IN bb_basketitem.idproduct%TYPE,
  5   p_qty       IN bb_basketitem.quantity%TYPE,
  6   p_price     IN bb_basketitem.price%TYPE,
  7   p_size      IN bb_basketitem.option1%TYPE,
  8   p_form      IN bb_basketitem.option2%TYPE)
  9  AS 
 10  BEGIN
 11    INSERT INTO bb_basketitem (idbasketitem, idproduct, quantity, price,
 12                               idbasket, option1, option2)
 13    VALUES (bb_idbasketitem_seq.NEXTVAL, p_produid, p_qty, p_price,
 14            p_baskid, p_size, p_form);
 15    COMMIT;
 16  END BASKET_ADD_SP;
 17  /

Procedure BASKET_ADD_SP compiled

SQL> BEGIN
  2    basket_add_sp(14,8,1,10.80,2,4);
  3  END;
  4  /

Error starting at line : 258 File @ C:\Users\Joshua\Documents\itse1345\competency_3\competency3_2\ho5\HO#5.sql
In command -
BEGIN
  basket_add_sp(14,8,1,10.80,2,4);
END;
Error report -
ORA-01438: value larger than specified precision allowed for this column
ORA-06512: at "ITSE1345-BB.BASKET_ADD_SP", line 10
ORA-06512: at line 2
01438. 00000 -  "value larger than specified precision allowed for this column"
*Cause:    When inserting or updating records, a numeric value was entered
           that exceeded the precision defined for the column.
*Action:   Enter a value that complies with the numeric column's precision,
           or use the MODIFY option with the ALTER TABLE command to expand
           the precision.
SQL> SELECT *
  2  FROM bb_basketitem;

                                       HO5-JOSHUA MEMBRENO                                        
                ID                                                  
IDBASKETITEM  PROD PRICE   QUANTITY   IDBASKET    OPTION1    OPTION2
------------ ----- ----- ---------- ---------- ---------- ----------
          15     6     5          1          3          1          4
          16     8  10.8          2          3          2          4
          17     4  28.5          1          4                      
          18     7  10.8          1          5          2          3
          19     8  10.8          1          5          2          3
          20     9    10          1          5          2          3
          21    10    10          1          5          2          3
          22    10    10          2          6          2          4
          23     2 129.99          1          6                      
          24     7  10.8          1          7          2          3
          25     8  10.8          1          7          2          3
          26     7  10.8          1          8          2          3
          27     8  10.8          1          8          2          3
          28     7  10.8          1          9          2          3
          29     8  10.8          1          9          2          3
          30     6     5          1         10          1          3
          31     8   5.4          1         10          1          3
          32     4  28.5          1         10                      
          33     9    10          1         11          2          3
          34     8  10.8          2         12          2          3
          35     9    10          2         12          2          3
          36     6    10          2         12          2          3
          37     7  10.8          1         12          2          3
          38     9    10          2         13          2          3
          40     8  10.8          1         15          2          3
          41     7   5.4          1         15          1          3
          42     8  10.8          1         16          2          3
          43     7   5.4          1         16          1          3
          51     8  10.8          1         14          2          4
          53     8  10.8          1         14          2          4
          50     8  10.8          1         14          2          4
          55     8  10.8          1         14          2          4
          52     8  10.8          1         14          2          4
          57     8  10.8          1         14          2          4
          54     8  10.8          1         14          2          4
          59     8  10.8          1         14          2          4
          56     8  10.8          1         14          2          4
          61     8  10.8          1         14          2          4
          58     8  10.8          1         14          2          4
          63     8  10.8          1         14          2          4
          60     8  10.8          1         14          2          4
          65     8  10.8          1         14          2          4
          62     8  10.8          1         14          2          4
          67     8  10.8          1         14          2          4
          64     8  10.8          1         14          2          4
          69     8  10.8          1         14          2          4
          66     8  10.8          1         14          2          4
          71     8  10.8          1         14          2          4
          68     8  10.8          1         14          2          4
          73     8  10.8          1         14          2          4
          70     8  10.8          1         14          2          4
          75     8  10.8          1         14          2          4
          72     8  10.8          1         14          2          4
          77     8  10.8          1         14          2          4
          74     8  10.8          1         14          2          4
          79     8  10.8          1         14          2          4
          76     8  10.8          1         14          2          4
          81     8  10.8          1         14          2          4
          78     8  10.8          1         14          2          4
          83     8  10.8          1         14          2          4
          80     8  10.8          1         14          2          4
          85     8  10.8          1         14          2          4
          82     8  10.8          1         14          2          4
          87     8  10.8          1         14          2          4
          84     8  10.8          1         14          2          4
          89     8  10.8          1         14          2          4
          86     8  10.8          1         14          2          4
          91     8  10.8          1         14          2          4
          88     8  10.8          1         14          2          4
          93     8  10.8          1         14          2          4
          90     8  10.8          1         14          2          4
          95     8  10.8          1         14          2          4
          92     8  10.8          1         14          2          4
          97     8  10.8          1         14          2          4
          94     8  10.8          1         14          2          4
          99     8  10.8          1         14          2          4
          96     8  10.8          1         14          2          4
          44     7  10.8          3         17          2          3
          98     8  10.8          1         14          2          4
          45     8  10.8          3         17          2          3

80 rows selected. 

SQL> /
SQL> -- # 5-9
SQL> CREATE OR REPLACE 
  2  PROCEDURE MEMBER_CK_SP
  3  (p_usrnm    IN VARCHAR2,
  4   p_pswrd    IN OUT VARCHAR2,
  5   p_valcook  OUT VARCHAR2,
  6   p_check    OUT VARCHAR2)
  7  AS
  8  BEGIN
  9    SELECT firstname ||' '|| lastname, cookie
 10    INTO p_pswrd, p_valcook
 11    FROM bb_shopper
 12    WHERE username = p_usrnm
 13    AND password = p_pswrd;
 14    p_check := 'VALID';
 15  EXCEPTION
 16      WHEN no_data_found THEN
 17          p_check := 'INVALID';
 18  END MEMBER_CK_SP;
 19  /

Procedure MEMBER_CK_SP compiled

SQL> DECLARE
  2    lv_usrn bb_shopper.username%TYPE := 'rat55'; 
  3    lv_pass VARCHAR2(25) := 'kile';
  4    lv_valcook bb_shopper.cookie%TYPE;
  5    lv_check VARCHAR2(10);
  6  BEGIN
  7      MEMBER_CK_SP(lv_usrn, lv_pass, lv_valcook, lv_check);
  8      IF lv_check = 'INVALID' THEN
  9           DBMS_OUTPUT.PUT_LINE(lv_check);
 10      ELSE
 11           DBMS_OUTPUT.PUT_LINE(lv_pass ||' '|| lv_valcook);
 12     END IF;
 13  --EXCEPTION
 14  --    WHEN no_data_found THEN
 15  --        lv_check := 'INVALID';
 16  END;
 17  /
Kenny Ratmans 0


PL/SQL procedure successfully completed.

SQL> DECLARE
  2    lv_usrn bb_shopper.username%TYPE := 'rat'; 
  3    lv_pass VARCHAR2(25) := 'kile';
  4    lv_valcook bb_shopper.cookie%TYPE;
  5    lv_check VARCHAR2(10);
  6  BEGIN
  7      MEMBER_CK_SP(lv_usrn, lv_pass, lv_valcook, lv_check);
  8      IF lv_check = 'INVALID' THEN
  9           DBMS_OUTPUT.PUT_LINE(lv_check);
 10      ELSE
 11           DBMS_OUTPUT.PUT_LINE(lv_pass ||' '|| lv_valcook);
 12     END IF;
 13  EXCEPTION
 14      WHEN no_data_found THEN
 15  DBMS_OUTPUT.PUT_LINE(lv_check);
 16  END;
 17  /
INVALID


PL/SQL procedure successfully completed.

SQL> CLEAR COLUMNS
SQL> CLEAR BRAKES
SP2-0158: unknown CLEAR option "brakes"
SQL> TTITLE OFF
SQL> TTITLE CENTER 'HO5-JOSHUA MEMBRENO'
SQL> COLUMN IDPRODUCT HEADING 'ID|PROD' FORMAT A5 WRAP
SQL> COLUMN PRODUCTNAME HEADING 'PROD|NAME' FORMAT A5 WRAP
SQL> COLUMN DESCRIPTION HEADING 'DESC' FORMAT A10 WRAP
SQL> COLUMN PRODUCTIMAGE HEADING 'PROD|IMAGE' FORMAT A5
SQL> COLUMN PRICE HEADING 'PRICE' FORMAT A5
SQL> COLUMN SALESTART HEADING 'SALE|START' FORMAT A8
SQL> COLUMN SALEEND HEADING 'SALE|END' FORMAT A8
SQL> COLUMN SALEPRICE HEADING 'SALE|PRICE' FORMAT A5 WRAP
SQL> COLUMN ACTIVE HEADING '|ACTIVE' FORMAT A5
SQL> COLUMN FEATURED HEADING '|FEATURED' FORMAT A5 WRAP
SQL> COLUMN FEATURESTART HEADING 'FEATURE | START' FORMAT A2
SQL> COLUMN FEATUREEND HEADING 'FEATURE | END' FORMAT A2
SQL> COLUMN TYPE HEADING '|TYPE' FORMAT A2
SQL> COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A5 WRAP
SQL> COLUMN STOCK HEADING 'STOCK' FORMAT A2 WRAP
SQL> COLUMN ORDERED HEADING 'ORDERED' FORMAT A5 WRAP
SQL> COLUMN REORDER HEADING 'REORDER' FORMAT A5 WRAP
SQL> COLUMN USED HEADING 'USED' FORMAT A15 WRAP
SQL> COLUMN MONTH HEADING 'MONTH' FORMAT A5 WRAP
SQL> COLUMN PROMO_FLAG HEADING 'PROM|FLAG' FORMAT A5 WRAP
SQL> COLUMN USED HEADING 'USED' FORMAT A5 WRAP
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> --COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A2
SQL> spool off
