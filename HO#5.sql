-- Joshua Membreno

-- #5-1
CREATE OR REPLACE 
PROCEDURE prod_name_sp
  (p_prodid IN bb_product.idproduct%TYPE,
   p_descrip IN bb_product.description%TYPE)
  IS
BEGIN
  UPDATE bb_product
    SET description = p_descrip
    WHERE idproduct = p_prodid;
  COMMIT;
END;
/
BEGIN
prod_name_sp(1,'CapressoBar Model #388');
END;
/
SELECT *
  FROM bb_product;
/
-- #5-2
CREATE OR REPLACE 
PROCEDURE PROD_ADD_SP 
(p_name IN bb_product.productname%TYPE,
 p_descrip IN bb_product.description%TYPE,
 p_image IN bb_product.productimage%TYPE,
 p_price IN bb_product.price%TYPE,
 p_active_st IN bb_product.active%TYPE)
 AS 
BEGIN
  INSERT INTO bb_product
   (idproduct, productname, description, productimage, price, active)
  VALUES
   (BB_PRODID_SEQ.nextval,p_name, p_descrip, p_image, p_price, p_active_st);
   COMMIT;
END PROD_ADD_SP;
/
DELETE FROM bb_product WHERE
productname = 'Roasted Blend';
COMMIT;
/
BEGIN
prod_add_sp('Roasted Blend','Well-balanced mix of roasted beans, medium body',
'roasted.jpg', 9.50, 1);
END;
/
SELECT *
FROM bb_product
WHERE productname = 'Roasted Blend';
/
-- #5-3
CREATE OR REPLACE 
PROCEDURE TAX_COST_SP 
(p_state IN bb_tax.state%TYPE,
 p_subtot IN bb_basket.subtotal%TYPE,
 p_taxes OUT NUMBER)
AS 
    lv_taxes bb_tax.taxrate%TYPE;
BEGIN
  SELECT taxrate * p_subtot
  INTO lv_taxes
  FROM bb_tax
  WHERE state = p_state;
  
  IF lv_taxes IS NULL THEN
    p_taxes := 0;
  ELSE 
    p_taxes := lv_taxes;
  END IF;
  
END TAX_COST_SP;
/
DECLARE 
    lv_taxes NUMBER(7,2);
BEGIN
    TAX_COST_SP('VA',100,lv_taxes);
DBMS_OUTPUT.PUT_LINE('Your taxes are:'|| TO_CHAR(lv_taxes, '$999.99'));
END;
/    
-- #5-4
DELETE FROM bb_basketitem WHERE
    idbasketitem = 44;
DELETE FROM bb_basketitem WHERE
    idbasketitem = 45;
DELETE FROM bb_basket WHERE
    idbasket = 17;
CREATE OR REPLACE PROCEDURE BASKET_CONFIRM_SP 
(p_idbask    IN  bb_basket.idbasket%TYPE,
 p_subtotal  IN  bb_basket.subtotal%TYPE,
 p_shipping  IN  bb_basket.shipping%TYPE,
 p_tax       IN  bb_basket.tax%TYPE,
 p_total     IN  bb_basket.total%TYPE
 )
IS 
BEGIN
  UPDATE bb_basket
    SET subtotal = p_subtotal,
        shipping = p_shipping,
        tax = p_tax,
        total = p_total,
        orderplaced = 1
    WHERE idbasket = p_idbask;
    COMMIT;
END BASKET_CONFIRM_SP;
/   
INSERT ALL 
    INTO bb_basket (idbasket, quantity, idshopper, orderplaced, subtotal,
                       total, shipping, tax, dtcreated, promo)
       VALUES (17,2,22,0,0,0,0,0,'28-FEB-12',0) 

    INTO bb_basketitem (idbasketitem, idproduct, price, quantity, idbasket,
                           option1, option2)
       VALUES (44,7,10.8,3,17,2,3)
    INTO bb_basketitem (idbasketitem, idproduct, price, quantity, idbasket,
                           option1, option2)
       VALUES (45,8,10.8,3,17,2,3)
    SELECT * FROM DUAL;   
COMMIT;
/
BEGIN 
    basket_confirm_sp(17,64.80,8.00,1.94,74.74);
END;
/
SELECT subtotal, shipping, tax, total, orderplaced
FROM bb_basket
WHERE idbasket = 17;
/
-- # 5-5
CREATE OR REPLACE 
PROCEDURE STATUS_SHIP_SP
(p_baskid   IN  bb_basketstatus.idbasket%TYPE,
 p_date     IN  DATE,
 p_shipp    IN  bb_basketstatus.shipper%TYPE,
 p_shippnum IN  bb_basketstatus.shippingnum%TYPE)
AS 
BEGIN
  INSERT INTO bb_basketstatus (idstatus, idbasket, idstage, dtstage, 
            shipper, shippingnum)
    VALUES (bb_status_seq.nextval, p_baskid, 3, p_date, p_shipp, p_shippnum);
  commit;
END STATUS_SHIP_SP;
/
BEGIN
    STATUS_SHIP_SP(3, '20-FEB-12', 'UPS', 'ZW2384YXK4957');
END;
/
SELECT idstatus, idbasket, idstage, dtstage, shipper, shippingnum
FROM bb_basketstatus;
/
-- # 5-6
CREATE OR REPLACE 
PROCEDURE STATUS_SP 
(p_basketid     IN  bb_basketstatus.idbasket%TYPE,
 p_date         OUT bb_basketstatus.dtstage%TYPE,
 p_descr        OUT bb_basketstatus.notes%TYPE)
AS
lv_stage bb_basketstatus.idstage%TYPE;
CURSOR cur_stat IS
SELECT idstage, dtstage
  INTO lv_stage, p_date  
  FROM bb_basketstatus
  WHERE idbasket = p_basketid
  ORDER BY dtstage DESC;
BEGIN
  OPEN cur_stat;
  FETCH cur_stat INTO lv_stage, p_date;
  CASE lv_stage
    WHEN 1 THEN p_descr := 'Submitted and received';
    WHEN 2 THEN p_descr := 'Confirmed, processed, sent to shipping';
    WHEN 3 THEN p_descr := 'Shipped';
    WHEN 4 THEN p_descr := 'Cancelled';
    WHEN 5 THEN p_descr := 'Back-ordered';
    ELSE p_descr := 'Status not availiable.';
  END CASE;
END STATUS_SP;
/
DECLARE
    lv_date DATE;
    lv_desc VARCHAR2(50);
BEGIN
    STATUS_SP(4,lv_date, lv_desc);
    DBMS_OUTPUT.PUT_LINE(lv_date);
    DBMS_OUTPUT.PUT_LINE(lv_desc);

    STATUS_SP(6,lv_date, lv_desc);
    DBMS_OUTPUT.PUT_LINE(lv_date);
    DBMS_OUTPUT.PUT_LINE(lv_desc);
END;
/
-- #5-7
DELETE FROM bb_promolist WHERE
    year = 2012;
CREATE OR REPLACE 
PROCEDURE PROMO_SHIP_SP
(p_date     IN  DATE,
 p_month    IN  bb_promolist.month%TYPE,
 p_year     IN  bb_promolist.year%TYPE)
AS
lv_minim          bb_basket.idshopper%TYPE;
lv_maxim          bb_basket.idshopper%TYPE;
lv_date         bb_basket.dtcreated%TYPE;
lv_shopp      bb_basket.idshopper%TYPE;
lv_prom_flag    NUMBER;
BEGIN
  SELECT min(idshopper), max(idshopper)
  INTO lv_minim, lv_maxim
  FROM bb_basket;
  
  FOR i IN lv_minim .. lv_maxim LOOP
  SELECT max(dtcreated)
  INTO lv_date
  FROM bb_basket
  WHERE idshopper = i;
 
     IF p_date >= lv_date THEN
         SELECT count(idshopper)
         INTO lv_prom_flag
         FROM bb_promolist
         WHERE i = idshopper;
   
         IF lv_prom_flag = 1 THEN CONTINUE;
         ELSE 
            INSERT INTO bb_promolist (idshopper, month, year, promo_flag, used)
            VALUES(i, p_month, p_year, 1, 'N');
         END IF;
     END IF;
  END LOOP;
COMMIT;
END PROMO_SHIP_SP;
/
BEGIN
    PROMO_SHIP_SP('15-FEB-12', 'APR', 2012);
END;
/
SELECT *
FROM bb_promolist;
/
-- # 5-8
DELETE FROM bb_basketitem
WHERE idbasketitem > 43;
/
CREATE OR REPLACE 
PROCEDURE BASKET_ADD_SP 
(p_baskid    IN NUMBER,
 p_produid   IN NUMBER,
 p_price     IN NUMBER,
 p_qty       IN NUMBER,
 p_size      IN NUMBER,
 p_form      IN NUMBER)
AS 
BEGIN
  INSERT INTO bb_basketitem (idbasketitem, idproduct, quantity, price,
                             idbasket, option1, option2)
  VALUES (bb_idbasketitem_seq.NEXTVAL, p_produid, p_qty, p_price,
          p_baskid, p_size, p_form);
  COMMIT;
END BASKET_ADD_SP;
/
DECLARE
 lv_baskid    NUMBER(5,2) := 14;
 lv_produid   NUMBER(6,2) := 8.0;
 lv_price     NUMBER(22,2) := 10.80;
 lv_qty       NUMBER(22,2) := 1;
 lv_size      NUMBER(22,2) := 2;
 lv_form      NUMBER(22,2) := 4;
BEGIN
  basket_add_sp(lv_baskid, lv_produid, lv_price, lv_qty, lv_size, lv_form);
END;
/
SELECT *
FROM bb_basketitem;
/
-- # 5-9
CREATE OR REPLACE 
PROCEDURE MEMBER_CK_SP
(p_usrnm    IN VARCHAR2,
 p_pswrd    IN OUT VARCHAR2,
 p_valcook  OUT VARCHAR2,
 p_check    OUT VARCHAR2)
AS
BEGIN
  SELECT firstname ||' '|| lastname, cookie
  INTO p_pswrd, p_valcook
  FROM bb_shopper
  WHERE username = p_usrnm
  AND password = p_pswrd;
  p_check := 'VALID';
EXCEPTION
    WHEN no_data_found THEN
        p_check := 'INVALID';
END MEMBER_CK_SP;
/
DECLARE
  lv_usrn bb_shopper.username%TYPE := 'rat55'; 
  lv_pass VARCHAR2(25) := 'kile';
  lv_valcook bb_shopper.cookie%TYPE;
  lv_check VARCHAR2(10);
BEGIN
    MEMBER_CK_SP(lv_usrn, lv_pass, lv_valcook, lv_check);
    IF lv_check = 'INVALID' THEN
         DBMS_OUTPUT.PUT_LINE(lv_check);
    ELSE
         DBMS_OUTPUT.PUT_LINE(lv_pass ||' '|| lv_valcook);
   END IF;
END;
/
DECLARE
  lv_usrn bb_shopper.username%TYPE := 'rat'; 
  lv_pass VARCHAR2(25) := 'kile';
  lv_valcook bb_shopper.cookie%TYPE;
  lv_check VARCHAR2(10);
BEGIN
    MEMBER_CK_SP(lv_usrn, lv_pass, lv_valcook, lv_check);
    IF lv_check = 'INVALID' THEN
         DBMS_OUTPUT.PUT_LINE(lv_check);
    ELSE
         DBMS_OUTPUT.PUT_LINE(lv_pass ||' '|| lv_valcook);
   END IF;
EXCEPTION
    WHEN no_data_found THEN
DBMS_OUTPUT.PUT_LINE(lv_check);
END;
/
CLEAR COLUMNS
CLEAR BRAKES
TTITLE OFF
TTITLE CENTER 'HO5-JOSHUA MEMBRENO'
COLUMN IDPRODUCT HEADING 'ID|PROD' FORMAT A5 WRAP
COLUMN PRODUCTNAME HEADING 'PROD|NAME' FORMAT A5 WRAP
COLUMN DESCRIPTION HEADING 'DESC' FORMAT A10 WRAP
COLUMN PRODUCTIMAGE HEADING 'PROD|IMAGE' FORMAT A5 WRAP
COLUMN PRICE HEADING 'PRICE' FORMAT A5 WRAP
COLUMN SALESTART HEADING 'SALE|START' FORMAT A3 WRAP
COLUMN SALEEND HEADING 'SALE|END' FORMAT A3 WRAP
COLUMN SALEPRICE HEADING 'SALE|PRICE' FORMAT $9,999.99
COLUMN ACTIVE HEADING 'ACTIVE' FORMAT A5 WRAP
COLUMN FEATURED HEADING 'FEAT' FORMAT A4 WRAP
COLUMN FEATURESTART HEADING 'FEAT|START' FORMAT A4 WRAP
COLUMN FEATUREEND HEADING 'FEAT|END' FORMAT A4 WRAP
COLUMN TYPE HEADING 'TYPE' FORMAT A2 WRAP
COLUMN IDDEPARTMENT HEADING 'ID|DEP' FORMAT A4 WRAP
COLUMN STOCK HEADING 'STOCK' FORMAT A2 WRAP
COLUMN ORDERED HEADING 'ORDERED' FORMAT A5 WRAP
COLUMN REORDER HEADING 'RE|ORD' FORMAT A4 WRAP
COLUMN USED HEADING 'USED' FORMAT A15 WRAP
COLUMN MONTH HEADING 'MONTH' FORMAT A5 WRAP
COLUMN PROMO_FLAG HEADING 'PROM|FLAG' FORMAT A5 WRAP
COLUMN USED HEADING 'USED' FORMAT A5 WRAP
/