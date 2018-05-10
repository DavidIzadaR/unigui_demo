object frDataModule: TfrDataModule
  OldCreateOrder = False
  Height = 214
  Width = 324
  object frxReport: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42969.684152395800000000
    ReportOptions.LastChange = 42969.698446875000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 72
    Top = 49
    Datasets = <
      item
        DataSet = frxSales
        DataSetName = 'main'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        object Memo2: TfrxMemoView
          Left = 287.244280000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Sales by Customer')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 740.409927000000000000
        DataSet = frxSales
        DataSetName = 'main'
        RowCount = 0
        object mainCustomer: TfrxMemoView
          Left = 7.559060000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'Customer'
          DataSet = frxSales
          DataSetName = 'main'
          Memo.UTF8W = (
            '[main."Customer"]')
          SuppressRepeated = True
        end
        object mainPosted: TfrxMemoView
          Left = 132.283550000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          DataField = 'Posted'
          DataSet = frxSales
          DataSetName = 'main'
          Memo.UTF8W = (
            '[main."Posted"]')
          SuppressRepeated = True
        end
        object mainProduct: TfrxMemoView
          Left = 283.464750000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          DataField = 'Product'
          DataSet = frxSales
          DataSetName = 'main'
          Memo.UTF8W = (
            '[main."Product"]')
        end
        object mainQuantity: TfrxMemoView
          Left = 423.307360000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Quantity'
          DataSet = frxSales
          DataSetName = 'main'
          Memo.UTF8W = (
            '[main."Quantity"]')
        end
        object mainPrice: TfrxMemoView
          Left = 514.016080000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Price'
          DataSet = frxSales
          DataSetName = 'main'
          HAlign = haRight
          Memo.UTF8W = (
            '[main."Price"]')
        end
        object mainTotal: TfrxMemoView
          Left = 604.724800000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'Total'
          DataSet = frxSales
          DataSetName = 'main'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[main."Total"]')
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 185.196970000000000000
        Width = 740.409927000000000000
        object Memo1: TfrxMemoView
          Left = 665.197280000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
      end
    end
  end
  object frxSales: TfrxDBDataset
    UserName = 'main'
    CloseDataSource = False
    DataSet = qrySales
    BCDToCurrency = False
    Left = 144
    Top = 49
  end
  object frxPDFExport: TfrxPDFExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = False
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = True
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 216
    Top = 49
  end
  object qrySales: TFDQuery
    ConstraintsEnabled = True
    Connection = UniMainModule.Conn
    SQL.Strings = (
      'select * from viewSales')
    Left = 144
    Top = 120
  end
end
