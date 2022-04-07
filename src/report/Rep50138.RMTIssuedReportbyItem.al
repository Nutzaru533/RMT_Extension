report 50138 "RMT_Issued Report by Item"
{
  Caption = 'Issued Report by Item';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/IssuedReportbyItem.rdl';

  dataset
  {
  dataitem("Item Ledger Entry";
  "Item Ledger Entry")
  {
  RequestFilterFields = "Item No.", "Item Category Code", "Posting Date", "Location Code";
  DataItemTableView = sorting("Source No.", "Item Category Code")WHERE("Entry Type"=const("Negative Adjmt."));
  CalcFields = "Cost Amount (Actual)";

  column(Source_No_;
  "Source No.")
  {
  }
  column(Source_Type;
  "Source Type")
  {
  }
  column(vendorName;
  vendor.Name)
  {
  }
  column(Item_No_;
  "Item No.")
  {
  }
  column(Item_Category_Code;
  "Item Category Code")
  {
  }
  column(Description;
  item.Description)
  {
  }
  column(Unit_of_Measure_Code;
  "Unit of Measure Code")
  {
  }
  column(Cost_Amount__Expected_;
  "Cost Amount (Actual)")
  {
  }
  column(Quantity;
  Quantity)
  {
  }
  column(InventoryPostingGroup;
  item."Inventory Posting Group")
  {
  }
  column(CalAmount;
  CalAmount)
  {
  }
  column(Picture;
  Compyinformation.Picture)
  {
  }
  column(CompyinformationName;
  Compyinformation.Name)
  {
  }
  column(CompyinformationName2;
  Compyinformation."Name 2")
  {
  }
  column(showDeteil;
  showDeteil)
  {
  }
  column(Location_Code;
  "Location Code")
  {
  }
  column(Posting_Date;
  "Posting Date")
  {
  }
  column(locationName;
  location.Name)
  {
  }
  column(Document_No_;
  "Document No.")
  {
  }
  column(Entry_No_;
  "Entry No.")
  {
  }
  trigger OnAfterGetRecord()var begin
    Compyinformation.get;
    Compyinformation.CalcFields(Picture);
    vendor.reset;
    if not vendor.get("Source No.")then vendor.init;
    item.reset;
    if not item.get("Item No.")then item.Init();
    Clear(CalAmount);
    CalAmount:=abs(Quantity) * "Cost Amount (Actual)";
    if not location.get("Location Code")then location.init;
  end;
  }
  }
  requestpage
  {
    SaveValues = true;

    layout
    {
      area(Content)
      {
        group(GroupName)
        {
          Caption = 'Option';

          field(showDeteil;showDeteil)
          {
            Caption = 'Show Deteil';
            ApplicationArea = All;
          }
        }
      }
    }
    actions
    {
      area(processing)
      {
        action(ActionName)
        {
          ApplicationArea = All;
        }
      }
    }
    trigger OnOpenPage()var myInt: Integer;
    begin
      showDeteil:=true;
    end;
  }
  var vendor: Record Vendor;
  item: Record item;
  Compyinformation: Record "Company Information";
  CalAmount: Decimal;
  showDeteil: Boolean;
  location: Record Location;
}
