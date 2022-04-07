report 50146 "RMT_Issue Detail by location"
{
  Caption = 'Issued Report Detail by Location';
  UsageCategory = Administration;
  ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/IssueReportDetailbyLocation.rdl';

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
  item."Base Unit of Measure")
  {
  }
  column(Cost_Amount__Expected_;
  PurchasePrice)
  {
  }
  column(Quantity;
  Quantity2)
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
  column(postingdatefilter;
  postingdatefilter)
  {
  }
  column(locationFilter;
  locationFilter)
  {
  }
  column(itemfilter;
  itemfilter)
  {
  }
  column(itemcatefilter;
  itemcatefilter)
  {
  }
  trigger OnAfterGetRecord()var begin
    Compyinformation.get;
    Compyinformation.CalcFields(Picture);
    Clear(PurchasePrice);
    Quantity2:=0;
    if "Qty. per Unit of Measure" <> 1 then Quantity2:=Quantity / "Qty. per Unit of Measure" // add code
    else
      Quantity2:=Quantity;
    vendor.reset;
    if not vendor.get("Source No.")then vendor.init;
    item.reset;
    if not item.get("Item No.")then item.Init();
    Clear(CalAmount);
    //CalAmount := abs(Quantity) * "Cost Amount (Actual)";
    CalAmount:="Cost Amount (Actual)";
    PurchasePrice:=abs(CalAmount / Quantity2);
    if not location.get("Location Code")then location.init;
    postingdatefilter:="Item Ledger Entry".GetFilter("Posting Date");
    locationFilter:="Item Ledger Entry".GetFilter("Location Code");
    itemfilter:="Item Ledger Entry".GetFilter("Item No.");
    itemcatefilter:="Item Ledger Entry".GetFilter("Item Category Code");
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
  Quantity2: Decimal;
  Compyinformation: Record "Company Information";
  CalAmount: Decimal;
  showDeteil: Boolean;
  location: Record Location;
  PurchasePrice: Decimal;
  postingdatefilter: Text[100];
  locationFilter: Text[100];
  itemfilter: Text[100];
  itemcatefilter: Text[100];
}
