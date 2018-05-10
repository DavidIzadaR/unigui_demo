unit Interfaces;

interface

type

  IOperatorsEditorForm = interface
    ['{4F644ED8-2D7B-404A-A8AF-9E611064C316}']

    procedure ShowAsModal;
  end;

  IOrdersEditorForm = interface
    ['{B4440C3C-191B-4AFA-B42E-3F830B785309}']

    procedure ShowAsModal;
  end;

  ISalesReportForm = interface
    ['{4807E173-2AEC-4F01-915C-A52A6813A382}']

    procedure SetPDFUrl(const Value : string);

    procedure ShowAsModal;

    property PDFUrl : string write SetPDFUrl;
  end;

implementation

end.
