-- Joshua Membreno

-- #5-1
CREATE OR REPLACE PROCEDURE prod_name_sp
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
SELECT idproduct, description
  FROM bb_product;
/
-- #5-2
CREATE OR REPLACE PROCEDURE PROD_ADD_SP 
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
SELECT idproduct, productname, description, productimage, price, active
FROM bb_product
WHERE productname = 'Roasted Blend';
/
-- #5-3
CREATE OR REPLACE PROCEDURE TAX_COST_SP 
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
-- #