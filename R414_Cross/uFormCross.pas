unit uFormCross;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCrossPanelForm, uCross, pngimage, ExtCtrls,
  uBaseObject, Menus, uFormConsole, StdCtrls;

type
    {$REGION 'КЛАСС'}
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

    {$REGION 'Инициализация объектов'}
    procedure TformCross.FormCreate(Sender: TObject);
    begin
      self.cross := TCross.Create();
      self.cross.wireFinishCross := self.wireFinished;
      //лампочки
      //верхний блок :
      self.cross.addLamp(image128); //ПИТ(0)
      self.cross.addLamp(image127); //СИГН(1)
      self.cross.addLamp(image129); //ВЫЗ А(2)
      self.cross.addLamp(image130); //ВЫЗ Б(3)
      self.cross.addLamp(image131); //ВЫЗ ЦБ/МБ(4)
      self.cross.addLamp(image132); //ВЫЗ МБ(5)
      //средний блок
      self.cross.addLamp(image133); //1(6)
      self.cross.addLamp(image134); //2(7)
      self.cross.addLamp(image135); //3(8)
      self.cross.addLamp(image136); //4(9)
      self.cross.addLamp(image137); //5(10)
      self.cross.addLamp(image138); //6(11)
      self.cross.addLamp(image139); //7(12)
      self.cross.addLamp(image140); //8(13)
      self.cross.addLamp(image141); //9(14)
      self.cross.addLamp(image142); //ЦРК(15)
      self.cross.addLamp(image143); //ПИТ(16)

      //Объекты на которые можно тыкать
      self.cross.addObject(ESWITCH_6P, Image165, '1Б.сверху_справа_6поз'); //1 блок переключатель сверху справа.(0)

      self.cross.addObject(ESWITCH_3P, Image148, '1Б.НАПРА_НАПРБ'); //1 блок НАПРА НАПРБ(1)
      self.cross.addObject(ESWITCH_3P, Image149, '1Б.4ПР_2ПР'); //1 блок 4ПР 2 ПР(2)
      self.cross.addObject(ESWITCH_3P, Image150, '1Б.ВЫЗ_РАЗГ'); //1 блок выз разг(3)
      self.cross.addObject(ESWITCH_3P, Image151, '1Б.ГЕН_УУ'); //1 блок ген уу(4)
      self.cross.addObject(ESWITCH_3P, Image152, '1Б.КОМАПП_ГТ'); //1 блок комм апп гг(5)
      self.cross.addObject(ESWITCH_3P, Image153, '1Б.ЦБ.МБ'); //1 блок комм цб мб(6)

      self.cross.addObject(ESWITCH_3P, Image154, '2Б.1ЛИН'); //2 блок 1(7)
      self.cross.addObject(ESWITCH_3P, Image155, '2Б.2ЛИН'); //2 блок 2(8)
      self.cross.addObject(ESWITCH_3P, Image156, '2Б.3ЛИН'); //2 блок 3(9)
      self.cross.addObject(ESWITCH_3P, Image157, '2Б.4ЛИН'); //2 блок 4(10)
      self.cross.addObject(ESWITCH_3P, Image158, '2Б.5ЛИН'); //2 блок 5(11)
      self.cross.addObject(ESWITCH_3P, Image159, '2Б.6ЛИН'); //2 блок 6(12)
      self.cross.addObject(ESWITCH_3P, Image160, '2Б.7ЛИН'); //2 блок 7(13)
      self.cross.addObject(ESWITCH_3P, Image161, '2Б.8ЛИН'); //2 блок 8(14)
      self.cross.addObject(ESWITCH_3P, Image162, '2Б.9ЛИН'); //2 блок 9(15)
      self.cross.addObject(ESWITCH_3P, Image163, '2Б.ЦРК'); //2 блок црк(16)
      self.cross.addObject(ESWITCH_3P, Image164, '2Б.ВЫЗ80'); //2 блок 11(17)

      self.cross.addObject(EPOWER, Image166, '1Б.ПИТ'); //1 блок включение питания(18

      ///
      self.cross.addObject(ESWITCH_2PG, Image146, '1Б.ВКЛ_ПРИБ'); //1 блок ВКЛ питание прибора(19)
      self.cross.addObject(ESWITCH_2PV, Image144, '2Б.ПИТ'); //2 блок ПИТ(20)
      ///

      self.cross.addObject(ESWITCH_2PV, Image145, '2Б.ГГС'); //2 блок ГГС(21)
      self.cross.addObject(ESWITCH_2PV, Image147, '2Б.ЗУМ'); //2 блок ЗУМ(22)

      self.cross.addObject(EJACK4, Image121, '4ПР.НАПР_А'); //Напр А.(23)
      self.cross.addObject(EJACK4, Image122, '4ПР.НАПР_Б'); //Напр Б(24)

      self.cross.addObject(EBUTTON, Image123,'1Б.ОТКЛ_ЗУМ');  //откл зум(25)
      self.cross.addObject(EBUTTON, Image125,'1Б.СВЕРХУ_СПРАВА_а');  //сверху справа а(26)
      self.cross.addObject(EBUTTON, Image124,'1Б.СВЕРХУ_СПРАВА_b');  //сверху справа b(27)

      self.cross.addObject(EJACK4, Image1,'4ПР.КАН_1'); //Кан1(28)
      self.cross.addObject(EJACK4, Image2,'4ПР.АПП_1'); //АПП1(29)

      self.cross.addObject(EJACK4, Image3,'4ПР.КАН_2'); //Кан2(30
      self.cross.addObject(EJACK4, Image4,'4ПР.АПП_2'); //АПП2(31

      self.cross.addObject(EJACK4, Image5,'4ПР.КАН_3'); //Кан3(32
      self.cross.addObject(EJACK4, Image6,'4ПР.АПП_3'); //АПП3(33

      self.cross.addObject(EJACK4, Image8,'4ПР.КАН_4'); //Кан4(34
      self.cross.addObject(EJACK4, Image7,'4ПР.АПП_4'); //АПП4(35

      self.cross.addObject(EJACK4, Image9,'4ПР.КАН_5'); //Кан5(36
      self.cross.addObject(EJACK4, Image10,'4ПР.АПП_5'); //АПП5(37

      self.cross.addObject(EJACK4, Image11,'4ПР.КАН_6'); //Кан6(38
      self.cross.addObject(EJACK4, Image12,'4ПР.АПП_6'); //АПП6(39

      self.cross.addObject(EJACK4, Image13,'4ПР.КАН_7'); //Кан7(40
      self.cross.addObject(EJACK4, Image14,'4ПР.АПП_7'); //АПП7(41

      self.cross.addObject(EJACK4, Image15,'4ПР.КАН_8'); //Кан8(42
      self.cross.addObject(EJACK4, Image16,'4ПР.АПП_8'); //АПП8(43

      self.cross.addObject(EJACK4, Image17,'4ПР.КАН_9'); //Кан9(44
      self.cross.addObject(EJACK4, Image18,'4ПР.АПП_9'); //АПП9(45

      self.cross.addObject(EJACK4, Image19,'4ПР.КАН_10'); //Кан10(46
      self.cross.addObject(EJACK4, Image20,'4ПР.АПП_10'); //АПП10(47

      self.cross.addObject(EJACK4, Image21,'4ПР.КАН_11'); //Кан11(48
      self.cross.addObject(EJACK4, Image22,'4ПР.АПП_11'); //АПП11(49

      self.cross.addObject(EJACK4, Image23,'4ПР.КАН_12'); //Кан12(50
      self.cross.addObject(EJACK4, Image24,'4ПР.АПП_12'); //АПП12(51

      self.cross.addObject(EJACK4, Image25,'4ПР.КАН_13'); //Кан13(52
      self.cross.addObject(EJACK4, Image26,'4ПР.АПП_13'); //АПП13(53

      self.cross.addObject(EJACK4, Image27,'4ПР.КАН_14'); //Кан14(54
      self.cross.addObject(EJACK4, Image28,'4ПР.АПП_14'); //АПП14(55

      self.cross.addObject(EJACK4, Image29,'4ПР.КАН_15'); //Кан15(56
      self.cross.addObject(EJACK4, Image30,'4ПР.АПП_15'); //АПП15(57

      self.cross.addObject(EJACK4, Image31,'4ПР.КАН_16'); //Кан16(58
      self.cross.addObject(EJACK4, Image32,'4ПР.АПП_16'); //АПП16(59

      self.cross.addObject(EJACK4, Image33,'4ПР.КАН_17'); //Кан17(60
      self.cross.addObject(EJACK4, Image34,'4ПР.АПП_17'); //АПП17(61

      self.cross.addObject(EJACK4, Image35,'4ПР.КАН_18'); //Кан18(62
      self.cross.addObject(EJACK4, Image36,'4ПР.АПП_18'); //АПП18(63

      self.cross.addObject(EJACK4, Image38,'4ПР.КАН_19'); //Кан19(64
      self.cross.addObject(EJACK4, Image37,'4ПР.АПП_19'); //АПП19(65

      self.cross.addObject(EJACK4, Image39,'4ПР.КАН_20'); //Кан20(66
      self.cross.addObject(EJACK4, Image40,'4ПР.АПП_20'); //АПП20(67

      self.cross.addObject(EJACK4, Image41,'4ПР.КАН_21'); //Кан21(68
      self.cross.addObject(EJACK4, Image42,'4ПР.АПП_21'); //АПП21(69

      self.cross.addObject(EJACK4, Image43,'4ПР.КАН_22'); //Кан22(70
      self.cross.addObject(EJACK4, Image44,'4ПР.АПП_22'); //АПП22(71

      self.cross.addObject(EJACK4, Image45,'4ПР.КАН_23'); //Кан23(72
      self.cross.addObject(EJACK4, Image46,'4ПР.АПП_23'); //АПП23(73

      self.cross.addObject(EJACK4, Image47,'4ПР.КАН_24'); //Кан24(74
      self.cross.addObject(EJACK4, Image48,'4ПР.АПП_24'); //АПП24(75

      self.cross.addObject(EJACK4, Image49,'4ПР.КАН_25'); //Кан25(76
      self.cross.addObject(EJACK4, Image50,'4ПР.АПП_25'); //АПП25(77

      self.cross.addObject(EJACK4, Image51,'4ПР.КАН_26'); //Кан26(78
      self.cross.addObject(EJACK4, Image54,'4ПР.АПП_26'); //АПП26(79

      self.cross.addObject(EJACK4, Image53,'4ПР.КАН_27'); //Кан27(80
      self.cross.addObject(EJACK4, Image52,'4ПР.АПП_27'); //АПП27(81

      self.cross.addObject(EJACK4, Image55,'4ПР.КАН_28'); //Кан28(82
      self.cross.addObject(EJACK4, Image56,'4ПР.АПП_28'); //АПП28(83

      self.cross.addObject(EJACK4, Image57,'4ПР.КАН_29'); //Кан29(84
      self.cross.addObject(EJACK4, Image58,'4ПР.АПП_29'); //АПП29(85

      self.cross.addObject(EJACK4, Image59,'4ПР.КАН_30'); //Кан30(86
      self.cross.addObject(EJACK4, Image60,'4ПР.АПП_30'); //АПП30(87

      self.cross.addObject(EJACK4, Image61,'4ПР.КАН_31'); //Кан31(88
      self.cross.addObject(EJACK4, Image62,'4ПР.АПП_31'); //АПП31(89

      self.cross.addObject(EJACK4, Image64,'4ПР.КАН_32'); //Кан32(90
      self.cross.addObject(EJACK4, Image63,'4ПР.АПП_32'); //АПП32(91

      self.cross.addObject(EJACK4, Image65,'4ПР.КАН_33'); //Кан33(92
      self.cross.addObject(EJACK4, Image66,'4ПР.АПП_33'); //АПП33(93

      self.cross.addObject(EJACK4, Image67,'4ПР.КАН_34'); //Кан34(94
      self.cross.addObject(EJACK4, Image68,'4ПР.АПП_34'); //АПП34(95

      self.cross.addObject(EJACK4, Image69,'4ПР.КАН_35'); //Кан35(96
      self.cross.addObject(EJACK4, Image70,'4ПР.АПП_35'); //АПП35(97

      self.cross.addObject(EJACK4, Image72,'4ПР.КАН_36'); //Кан36(98
      self.cross.addObject(EJACK4, Image71,'4ПР.АПП_36'); //АПП36(99

      self.cross.addObject(EJACK4, Image73,'4ПР.КАН_37'); //Кан37(100
      self.cross.addObject(EJACK4, Image74,'4ПР.АПП_37'); //АПП37(101

      self.cross.addObject(EJACK4, Image75,'4ПР.КАН_38'); //Кан38
      self.cross.addObject(EJACK4, Image76,'4ПР.АПП_38'); //АПП38

      self.cross.addObject(EJACK4, Image77,'4ПР.КАН_39'); //Кан39
      self.cross.addObject(EJACK4, Image78,'4ПР.АПП_39'); //АПП39

      self.cross.addObject(EJACK4, Image79,'4ПР.КАН_40'); //Кан40
      self.cross.addObject(EJACK4, Image80,'4ПР.АПП_40'); //АПП40

      self.cross.addObject(EJACK4, Image81,'4ПР.КАН_41'); //Кан41
      self.cross.addObject(EJACK4, Image82,'4ПР.АПП_41'); //АПП41

      self.cross.addObject(EJACK4, Image83,'4ПР.КАН_42'); //Кан42
      self.cross.addObject(EJACK4, Image86,'4ПР.АПП_42'); //АПП42

      self.cross.addObject(EJACK4, Image84,'4ПР.КАН_43'); //Кан43
      self.cross.addObject(EJACK4, Image87,'4ПР.АПП_43'); //АПП43

      self.cross.addObject(EJACK4, Image85,'4ПР.КАН_44'); //Кан44
      self.cross.addObject(EJACK4, Image88,'4ПР.АПП_44'); //АПП44

      self.cross.addObject(EJACK4, Image105,'4ПР.КАН_45'); //Кан45
      self.cross.addObject(EJACK4, Image89,'4ПР.АПП_45'); //АПП45

      self.cross.addObject(EJACK4, Image106,'4ПР.КАН_46'); //Кан46
      self.cross.addObject(EJACK4, Image90,'4ПР.АПП_46'); //АПП46

      self.cross.addObject(EJACK4, Image107,'4ПР.КАН_47'); //Кан47
      self.cross.addObject(EJACK4, Image91,'4ПР.АПП_47'); //АПП47

      self.cross.addObject(EJACK4, Image108,'4ПР.КАН_48'); //Кан48
      self.cross.addObject(EJACK4, Image92,'4ПР.АПП_48'); //АПП48

      self.cross.addObject(EJACK4, Image109,'4ПР.КАН_49'); //Кан49
      self.cross.addObject(EJACK4, Image93,'4ПР.АПП_49'); //АПП49

      self.cross.addObject(EJACK4, Image110,'4ПР.КАН_50'); //Кан50
      self.cross.addObject(EJACK4, Image94,'4ПР.АПП_50'); //АПП50

      self.cross.addObject(EJACK4, Image111,'4ПР.КАН_51'); //Кан50
      self.cross.addObject(EJACK4, Image95,'4ПР.АПП_51'); //АПП50

      self.cross.addObject(EJACK4, Image112,'4ПР.КАН_52'); //Кан51
      self.cross.addObject(EJACK4, Image96,'4ПР.АПП_52'); //АПП51

      self.cross.addObject(EJACK4, Image113,'4ПР.КАН_53'); //Кан52
      self.cross.addObject(EJACK4, Image97,'4ПР.АПП_53'); //АПП52

      self.cross.addObject(EJACK4, Image114,'4ПР.КАН_54'); //Кан53
      self.cross.addObject(EJACK4, Image98,'4ПР.АПП_54'); //АПП53

      self.cross.addObject(EJACK4, Image115,'4ПР.КАН_55'); //Кан54
      self.cross.addObject(EJACK4, Image99,'4ПР.АПП_55'); //АПП54

      self.cross.addObject(EJACK4, Image116,'4ПР.КАН_56'); //Кан55
      self.cross.addObject(EJACK4, Image100,'4ПР.АПП_56'); //АПП55

      self.cross.addObject(EJACK4, Image117,'4ПР.КАН_57'); //Кан56
      self.cross.addObject(EJACK4, Image101,'4ПР.АПП_57'); //АПП56

      self.cross.addObject(EJACK4, Image118,'4ПР.КАН_58'); //Кан57
      self.cross.addObject(EJACK4, Image102,'4ПР.АПП_58'); //АПП57

      self.cross.addObject(EJACK4, Image119,'4ПР.КАН_59'); //Кан58
      self.cross.addObject(EJACK4, Image103,'4ПР.АПП_59'); //АПП58

      self.cross.addObject(EJACK4, Image120,'4ПР.КАН_60'); //Кан59
      self.cross.addObject(EJACK4, Image104,'4ПР.КАН_60'); //АПП59
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
