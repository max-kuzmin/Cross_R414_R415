unit uFormCross;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCrossPanelForm, uCross, pngimage, ExtCtrls,
  uBaseObject, Menus, uFormConsole, StdCtrls;

type
    {$REGION '�����'}
    TformCross = class(TForm)
      Image1: TImage;
      Image2: TImage;
      Image3: TImage;
      Image4: TImage;
      Image5: TImage;
      Image6: TImage;
      Image7: TImage;
      Image8: TImage;
      Image9: TImage;
      Image10: TImage;
      Image11: TImage;
      Image12: TImage;
      Image13: TImage;
      Image14: TImage;
      Image15: TImage;
      Image16: TImage;
      Image17: TImage;
      Image18: TImage;
      Image19: TImage;
      Image20: TImage;
      Image21: TImage;
      Image22: TImage;
      Image23: TImage;
      Image24: TImage;
      Image25: TImage;
      Image26: TImage;
      Image27: TImage;
      Image28: TImage;
      Image29: TImage;
      Image30: TImage;
      Image31: TImage;
      Image32: TImage;
      Image33: TImage;
      Image34: TImage;
      Image35: TImage;
      Image36: TImage;
      Image37: TImage;
      Image38: TImage;
      Image39: TImage;
      Image40: TImage;
      Image41: TImage;
      Image42: TImage;
      Image43: TImage;
      Image44: TImage;
      Image45: TImage;
      Image46: TImage;
      Image47: TImage;
      Image48: TImage;
      Image49: TImage;
      Image50: TImage;
      imgBackground: TImage;
      Image51: TImage;
      Image52: TImage;
      Image53: TImage;
      Image54: TImage;
      Image55: TImage;
      Image56: TImage;
      Image57: TImage;
      Image58: TImage;
      Image59: TImage;
      Image60: TImage;
      Image61: TImage;
      Image62: TImage;
      Image63: TImage;
      Image64: TImage;
      Image65: TImage;
      Image66: TImage;
      Image67: TImage;
      Image68: TImage;
      Image69: TImage;
      Image70: TImage;
      Image71: TImage;
      Image72: TImage;
      Image73: TImage;
      Image74: TImage;
      Image75: TImage;
      Image76: TImage;
      Image77: TImage;
      Image78: TImage;
      Image79: TImage;
      Image80: TImage;
      Image81: TImage;
      Image82: TImage;
      Image83: TImage;
      Image84: TImage;
      Image85: TImage;
      Image86: TImage;
      Image87: TImage;
      Image88: TImage;
      Image89: TImage;
      Image90: TImage;
      Image91: TImage;
      Image92: TImage;
      Image93: TImage;
      Image94: TImage;
      Image95: TImage;
      Image96: TImage;
      Image97: TImage;
      Image98: TImage;
      Image99: TImage;
      Image100: TImage;
      Image101: TImage;
      Image102: TImage;
      Image103: TImage;
      Image104: TImage;
      Image105: TImage;
      Image106: TImage;
      Image107: TImage;
      Image108: TImage;
      Image109: TImage;
      Image110: TImage;
      Image111: TImage;
      Image112: TImage;
      Image113: TImage;
      Image114: TImage;
      Image115: TImage;
      Image116: TImage;
      Image117: TImage;
      Image118: TImage;
      Image119: TImage;
      Image120: TImage;
      Image121: TImage;
      Image122: TImage;
      Image123: TImage;
      Image124: TImage;
      Image125: TImage;
      Image126: TImage;
      Image127: TImage;
      Image128: TImage;
      Image129: TImage;
      Image130: TImage;
      Image131: TImage;
      Image132: TImage;
      Image133: TImage;
      Image134: TImage;
      Image135: TImage;
      Image136: TImage;
      Image137: TImage;
      Image138: TImage;
      Image139: TImage;
      Image140: TImage;
      Image141: TImage;
      Image142: TImage;
      Image143: TImage;
      Image144: TImage;
      Image145: TImage;
      Image147: TImage;
      Image146: TImage;
      Image148: TImage;
      Image149: TImage;
      Image150: TImage;
      Image151: TImage;
      Image152: TImage;
      Image153: TImage;
      Image154: TImage;
      Image155: TImage;
      Image156: TImage;
      Image157: TImage;
      Image158: TImage;
      Image159: TImage;
      Image160: TImage;
      Image161: TImage;
      Image162: TImage;
      Image163: TImage;
      Image164: TImage;
      Image165: TImage;
    Image166: TImage;
      procedure FormCreate(Sender: TObject);
      procedure Image126Click(Sender: TObject);

      private

      public
          cross :TCross;
          procedure wireFinished;


    end;
    {$ENDREGION}

var
  formCross: TformCross;

implementation

{$R *.dfm}

    {$REGION '������������� ��������'}
    procedure TformCross.FormCreate(Sender: TObject);
    begin
      self.cross := TCross.Create();
      self.cross.wireFinishCross := self.wireFinished;
      //��������
      //������� ���� :
      self.cross.addLamp(image128); //���(0)
      self.cross.addLamp(image127); //����(1)
      self.cross.addLamp(image129); //��� �(2)
      self.cross.addLamp(image130); //��� �(3)
      self.cross.addLamp(image131); //��� ��/��(4)
      self.cross.addLamp(image132); //��� ��(5)
      //������� ����
      self.cross.addLamp(image133); //1(6)
      self.cross.addLamp(image134); //2(7)
      self.cross.addLamp(image135); //3(8)
      self.cross.addLamp(image136); //4(9)
      self.cross.addLamp(image137); //5(10)
      self.cross.addLamp(image138); //6(11)
      self.cross.addLamp(image139); //7(12)
      self.cross.addLamp(image140); //8(13)
      self.cross.addLamp(image141); //9(14)
      self.cross.addLamp(image142); //���(15)
      self.cross.addLamp(image143); //���(16)

      //������� �� ������� ����� ������
      self.cross.addObject(ESWITCH_6P, Image165, '1�.������_������_6���'); //1 ���� ������������� ������ ������.(0)

      self.cross.addObject(ESWITCH_3P, Image148, '1�.�����_�����'); //1 ���� ����� �����(1)
      self.cross.addObject(ESWITCH_3P, Image149, '1�.4��_2��'); //1 ���� 4�� 2 ��(2)
      self.cross.addObject(ESWITCH_3P, Image150, '1�.���_����'); //1 ���� ��� ����(3)
      self.cross.addObject(ESWITCH_3P, Image151, '1�.���_��'); //1 ���� ��� ��(4)
      self.cross.addObject(ESWITCH_3P, Image152, '1�.������_��'); //1 ���� ���� ��� ��(5)
      self.cross.addObject(ESWITCH_3P, Image153, '1�.��.��'); //1 ���� ���� �� ��(6)

      self.cross.addObject(ESWITCH_3P, Image154, '2�.1���'); //2 ���� 1(7)
      self.cross.addObject(ESWITCH_3P, Image155, '2�.2���'); //2 ���� 2(8)
      self.cross.addObject(ESWITCH_3P, Image156, '2�.3���'); //2 ���� 3(9)
      self.cross.addObject(ESWITCH_3P, Image157, '2�.4���'); //2 ���� 4(10)
      self.cross.addObject(ESWITCH_3P, Image158, '2�.5���'); //2 ���� 5(11)
      self.cross.addObject(ESWITCH_3P, Image159, '2�.6���'); //2 ���� 6(12)
      self.cross.addObject(ESWITCH_3P, Image160, '2�.7���'); //2 ���� 7(13)
      self.cross.addObject(ESWITCH_3P, Image161, '2�.8���'); //2 ���� 8(14)
      self.cross.addObject(ESWITCH_3P, Image162, '2�.9���'); //2 ���� 9(15)
      self.cross.addObject(ESWITCH_3P, Image163, '2�.���'); //2 ���� ���(16)
      self.cross.addObject(ESWITCH_3P, Image164, '2�.���80'); //2 ���� 11(17)

      self.cross.addObject(EPOWER, Image166, '1�.���'); //1 ���� ��������� �������(18

      ///
      self.cross.addObject(ESWITCH_2PG, Image146, '1�.���_����'); //1 ���� ��� ������� �������(19)
      self.cross.addObject(ESWITCH_2PV, Image144, '2�.���'); //2 ���� ���(20)
      ///

      self.cross.addObject(ESWITCH_2PV, Image145, '2�.���'); //2 ���� ���(21)
      self.cross.addObject(ESWITCH_2PV, Image147, '2�.���'); //2 ���� ���(22)

      self.cross.addObject(EJACK4, Image121, '4��.����_�'); //���� �.(23)
      self.cross.addObject(EJACK4, Image122, '4��.����_�'); //���� �(24)

      self.cross.addObject(EBUTTON, Image123,'1�.����_���');  //���� ���(25)
      self.cross.addObject(EBUTTON, Image125,'1�.������_������_�');  //������ ������ �(26)
      self.cross.addObject(EBUTTON, Image124,'1�.������_������_b');  //������ ������ b(27)

      self.cross.addObject(EJACK4, Image1,'4��.���_1'); //���1(28)
      self.cross.addObject(EJACK4, Image2,'4��.���_1'); //���1(29)

      self.cross.addObject(EJACK4, Image3,'4��.���_2'); //���2(30
      self.cross.addObject(EJACK4, Image4,'4��.���_2'); //���2(31

      self.cross.addObject(EJACK4, Image5,'4��.���_3'); //���3(32
      self.cross.addObject(EJACK4, Image6,'4��.���_3'); //���3(33

      self.cross.addObject(EJACK4, Image8,'4��.���_4'); //���4(34
      self.cross.addObject(EJACK4, Image7,'4��.���_4'); //���4(35

      self.cross.addObject(EJACK4, Image9,'4��.���_5'); //���5(36
      self.cross.addObject(EJACK4, Image10,'4��.���_5'); //���5(37

      self.cross.addObject(EJACK4, Image11,'4��.���_6'); //���6(38
      self.cross.addObject(EJACK4, Image12,'4��.���_6'); //���6(39

      self.cross.addObject(EJACK4, Image13,'4��.���_7'); //���7(40
      self.cross.addObject(EJACK4, Image14,'4��.���_7'); //���7(41

      self.cross.addObject(EJACK4, Image15,'4��.���_8'); //���8(42
      self.cross.addObject(EJACK4, Image16,'4��.���_8'); //���8(43

      self.cross.addObject(EJACK4, Image17,'4��.���_9'); //���9(44
      self.cross.addObject(EJACK4, Image18,'4��.���_9'); //���9(45

      self.cross.addObject(EJACK4, Image19,'4��.���_10'); //���10(46
      self.cross.addObject(EJACK4, Image20,'4��.���_10'); //���10(47

      self.cross.addObject(EJACK4, Image21,'4��.���_11'); //���11(48
      self.cross.addObject(EJACK4, Image22,'4��.���_11'); //���11(49

      self.cross.addObject(EJACK4, Image23,'4��.���_12'); //���12(50
      self.cross.addObject(EJACK4, Image24,'4��.���_12'); //���12(51

      self.cross.addObject(EJACK4, Image25,'4��.���_13'); //���13(52
      self.cross.addObject(EJACK4, Image26,'4��.���_13'); //���13(53

      self.cross.addObject(EJACK4, Image27,'4��.���_14'); //���14(54
      self.cross.addObject(EJACK4, Image28,'4��.���_14'); //���14(55

      self.cross.addObject(EJACK4, Image29,'4��.���_15'); //���15(56
      self.cross.addObject(EJACK4, Image30,'4��.���_15'); //���15(57

      self.cross.addObject(EJACK4, Image31,'4��.���_16'); //���16(58
      self.cross.addObject(EJACK4, Image32,'4��.���_16'); //���16(59

      self.cross.addObject(EJACK4, Image33,'4��.���_17'); //���17(60
      self.cross.addObject(EJACK4, Image34,'4��.���_17'); //���17(61

      self.cross.addObject(EJACK4, Image35,'4��.���_18'); //���18(62
      self.cross.addObject(EJACK4, Image36,'4��.���_18'); //���18(63

      self.cross.addObject(EJACK4, Image38,'4��.���_19'); //���19(64
      self.cross.addObject(EJACK4, Image37,'4��.���_19'); //���19(65

      self.cross.addObject(EJACK4, Image39,'4��.���_20'); //���20(66
      self.cross.addObject(EJACK4, Image40,'4��.���_20'); //���20(67

      self.cross.addObject(EJACK4, Image41,'4��.���_21'); //���21(68
      self.cross.addObject(EJACK4, Image42,'4��.���_21'); //���21(69

      self.cross.addObject(EJACK4, Image43,'4��.���_22'); //���22(70
      self.cross.addObject(EJACK4, Image44,'4��.���_22'); //���22(71

      self.cross.addObject(EJACK4, Image45,'4��.���_23'); //���23(72
      self.cross.addObject(EJACK4, Image46,'4��.���_23'); //���23(73

      self.cross.addObject(EJACK4, Image47,'4��.���_24'); //���24(74
      self.cross.addObject(EJACK4, Image48,'4��.���_24'); //���24(75

      self.cross.addObject(EJACK4, Image49,'4��.���_25'); //���25(76
      self.cross.addObject(EJACK4, Image50,'4��.���_25'); //���25(77

      self.cross.addObject(EJACK4, Image51,'4��.���_26'); //���26(78
      self.cross.addObject(EJACK4, Image54,'4��.���_26'); //���26(79

      self.cross.addObject(EJACK4, Image53,'4��.���_27'); //���27(80
      self.cross.addObject(EJACK4, Image52,'4��.���_27'); //���27(81

      self.cross.addObject(EJACK4, Image55,'4��.���_28'); //���28(82
      self.cross.addObject(EJACK4, Image56,'4��.���_28'); //���28(83

      self.cross.addObject(EJACK4, Image57,'4��.���_29'); //���29(84
      self.cross.addObject(EJACK4, Image58,'4��.���_29'); //���29(85

      self.cross.addObject(EJACK4, Image59,'4��.���_30'); //���30(86
      self.cross.addObject(EJACK4, Image60,'4��.���_30'); //���30(87

      self.cross.addObject(EJACK4, Image61,'4��.���_31'); //���31(88
      self.cross.addObject(EJACK4, Image62,'4��.���_31'); //���31(89

      self.cross.addObject(EJACK4, Image64,'4��.���_32'); //���32(90
      self.cross.addObject(EJACK4, Image63,'4��.���_32'); //���32(91

      self.cross.addObject(EJACK4, Image65,'4��.���_33'); //���33(92
      self.cross.addObject(EJACK4, Image66,'4��.���_33'); //���33(93

      self.cross.addObject(EJACK4, Image67,'4��.���_34'); //���34(94
      self.cross.addObject(EJACK4, Image68,'4��.���_34'); //���34(95

      self.cross.addObject(EJACK4, Image69,'4��.���_35'); //���35(96
      self.cross.addObject(EJACK4, Image70,'4��.���_35'); //���35(97

      self.cross.addObject(EJACK4, Image72,'4��.���_36'); //���36(98
      self.cross.addObject(EJACK4, Image71,'4��.���_36'); //���36(99

      self.cross.addObject(EJACK4, Image73,'4��.���_37'); //���37(100
      self.cross.addObject(EJACK4, Image74,'4��.���_37'); //���37(101

      self.cross.addObject(EJACK4, Image75,'4��.���_38'); //���38
      self.cross.addObject(EJACK4, Image76,'4��.���_38'); //���38

      self.cross.addObject(EJACK4, Image77,'4��.���_39'); //���39
      self.cross.addObject(EJACK4, Image78,'4��.���_39'); //���39

      self.cross.addObject(EJACK4, Image79,'4��.���_40'); //���40
      self.cross.addObject(EJACK4, Image80,'4��.���_40'); //���40

      self.cross.addObject(EJACK4, Image81,'4��.���_41'); //���41
      self.cross.addObject(EJACK4, Image82,'4��.���_41'); //���41

      self.cross.addObject(EJACK4, Image83,'4��.���_42'); //���42
      self.cross.addObject(EJACK4, Image86,'4��.���_42'); //���42

      self.cross.addObject(EJACK4, Image84,'4��.���_43'); //���43
      self.cross.addObject(EJACK4, Image87,'4��.���_43'); //���43

      self.cross.addObject(EJACK4, Image85,'4��.���_44'); //���44
      self.cross.addObject(EJACK4, Image88,'4��.���_44'); //���44

      self.cross.addObject(EJACK4, Image105,'4��.���_45'); //���45
      self.cross.addObject(EJACK4, Image89,'4��.���_45'); //���45

      self.cross.addObject(EJACK4, Image106,'4��.���_46'); //���46
      self.cross.addObject(EJACK4, Image90,'4��.���_46'); //���46

      self.cross.addObject(EJACK4, Image107,'4��.���_47'); //���47
      self.cross.addObject(EJACK4, Image91,'4��.���_47'); //���47

      self.cross.addObject(EJACK4, Image108,'4��.���_48'); //���48
      self.cross.addObject(EJACK4, Image92,'4��.���_48'); //���48

      self.cross.addObject(EJACK4, Image109,'4��.���_49'); //���49
      self.cross.addObject(EJACK4, Image93,'4��.���_49'); //���49

      self.cross.addObject(EJACK4, Image110,'4��.���_50'); //���50
      self.cross.addObject(EJACK4, Image94,'4��.���_50'); //���50

      self.cross.addObject(EJACK4, Image111,'4��.���_51'); //���50
      self.cross.addObject(EJACK4, Image95,'4��.���_51'); //���50

      self.cross.addObject(EJACK4, Image112,'4��.���_52'); //���51
      self.cross.addObject(EJACK4, Image96,'4��.���_52'); //���51

      self.cross.addObject(EJACK4, Image113,'4��.���_53'); //���52
      self.cross.addObject(EJACK4, Image97,'4��.���_53'); //���52

      self.cross.addObject(EJACK4, Image114,'4��.���_54'); //���53
      self.cross.addObject(EJACK4, Image98,'4��.���_54'); //���53

      self.cross.addObject(EJACK4, Image115,'4��.���_55'); //���54
      self.cross.addObject(EJACK4, Image99,'4��.���_55'); //���54

      self.cross.addObject(EJACK4, Image116,'4��.���_56'); //���55
      self.cross.addObject(EJACK4, Image100,'4��.���_56'); //���55

      self.cross.addObject(EJACK4, Image117,'4��.���_57'); //���56
      self.cross.addObject(EJACK4, Image101,'4��.���_57'); //���56

      self.cross.addObject(EJACK4, Image118,'4��.���_58'); //���57
      self.cross.addObject(EJACK4, Image102,'4��.���_58'); //���57

      self.cross.addObject(EJACK4, Image119,'4��.���_59'); //���58
      self.cross.addObject(EJACK4, Image103,'4��.���_59'); //���58

      self.cross.addObject(EJACK4, Image120,'4��.���_60'); //���59
      self.cross.addObject(EJACK4, Image104,'4��.���_60'); //���59
    end;
    {$ENDREGION}

  procedure TformCross.Image126Click(Sender: TObject);
  begin
    if self.cross.wireCreation = false then
    begin
      self.image126.Visible := false;
      self.cross.wireCreation := true;
    end;
  end;

  procedure TformCross.wireFinished;
  begin
    self.image126.Visible := true;
    self.cross.wireCreation := false;
  end;

end.
