report 50147 "RMT_Summary Rec Detail Hide"
{
  Caption = 'Summary Receiving Suplier Detail';
  //UsageCategory = Administration;
  //ApplicationArea = All;
  DefaultLayout = RDLC;
  RDLCLayout = 'Report/Layout/SummaryReceivingSuplierDetail.rdl';

  dataset
  {
  dataitem("Item Ledger Entry";
  "Item Ledger Entry")
  {
  RequestFilterFields = "Item No.", "Item Category Code", "Document date";
  DataItemTableView = sorting("Source No.", "Item Category Code")WHERE("Entry Type"=const(Purchase));
  CalcFields = "Cost Amount (Actual)", "Cost Amount (Expected)";

  column(Entry_No_;
  "Entry No.")
  {
  }
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
  xItemCategoryCode)
  {
  }
  column(Description;
  Description)
  {
  }
  column(Unit_of_Measure_Code;
  "Unit of Measure Code")
  {
  }
  column(Cost_Amount__Expected_;
  unitprice)
  {
  }
  column(Quantity;
  Quantity)
  {
  }
  column(InventoryPostingGroup;
  xInventoryPostingGroup)
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
  trigger OnAfterGetRecord()var begin
    Compyinformation.get;
    Compyinformation.CalcFields(Picture);
    xItemCategoryCode:='';
    xInventoryPostingGroup:='';
    vendor.reset;
    if not vendor.get("Source No.")then vendor.init;
    item.reset;
    if not item.get("Item No.")then item.Init();
    Clear(CalAmount);
    clear(unitprice);
    xItemCategoryCode:=Format("Item Category Code");
    xInventoryPostingGroup:=Format(item."Inventory Posting Group");
    if xItemCategoryCode = '' then xItemCategoryCode:='Expense';
    if xInventoryPostingGroup = '' then xInventoryPostingGroup:='Expense';
    // if "Cost Amount (Actual)" <> 0 then
    //     CalAmount := abs(Quantity) * abs("Cost Amount (Actual)")
    // else
    //     CalAmount := abs(Quantity) * abs("Cost Amount (Expected)");
    if "Cost Amount (Actual)" <> 0 then CalAmount:=abs("Cost Amount (Actual)")
    else
      CalAmount:=abs("Cost Amount (Expected)");
    if CalAmount <> 0 then unitprice:=CalAmount / Quantity;
  end;
  }
  }
  requestpage
  {
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
  unitprice: Decimal;
  xItemCategoryCode: Text[50];
  xInventoryPostingGroup: text[50];
}
