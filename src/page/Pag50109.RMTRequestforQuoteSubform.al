page 50109 "RMT RequestforQuote Subform"
{
  AutoSplitKey = true;
  Caption = 'Lines';
  DelayedInsert = true;
  LinksAllowed = false;
  MultipleNewLines = true;
  PageType = ListPart;
  SourceTable = "Purchase Line";
  SourceTableView = WHERE("Document Type"=FILTER(Quote));

  //SourceTableView = WHERE("Document Type" = FILTER(Quote));
  layout
  {
    area(content)
    {
      repeater(Control1)
      {
        ShowCaption = false;

        // field(Type; Type)
        // {
        //     ApplicationArea = Advanced;
        //     ToolTip = 'Specifies the line type.';
        //     trigger OnValidate()
        //     begin
        //         NoOnAfterValidate();
        //         UpdateEditableOnRow();
        //         UpdateTypeText();
        //         DeltaUpdateTotals();
        //     end;
        // }
        field("RMT Item No.";Rec."RMT Item No.")
        {
          ToolTip = 'Specifies the value of the Item No. field';
          ApplicationArea = All;
        }
        field(Description;Description)
        {
          ApplicationArea = All;
        }
        field("Description 2";"Description 2")
        {
          ApplicationArea = All;
        }
        field("RMT Selected Vendor No.";"RMT Selected Vendor No.")
        {
          ApplicationArea = All;
        }
        field("RMT Vendor Select Price";"RMT Vendor Select Price")
        {
          //Editable = false;
          ApplicationArea = All;
        }
        field("RMT Quantity";Rec."RMT Quantity")
        {
          ToolTip = 'Specifies the value of the Quantity field';
          ApplicationArea = All;
        }
        field("RMT Unit of Measure";Rec."RMT Unit of Measure")
        {
          ApplicationArea = All;
        }
        field("RMT Vendor No.1";Rec."RMT Vendor No.1")
        {
          ToolTip = 'Specifies the value of the Vendor No.1 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Price 1";Rec."RMT Vendor Price 1")
        {
          ToolTip = 'Specifies the value of the Vendor Price 1 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No.2";Rec."RMT Vendor No.2")
        {
          ToolTip = 'Specifies the value of the Vendor No.2 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Price 2";Rec."RMT Vendor Price 2")
        {
          ToolTip = 'Specifies the value of the Vendor Price 2 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No.3";Rec."RMT Vendor No.3")
        {
          ToolTip = 'Specifies the value of the Vendor No.3 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Price 3";Rec."RMT Vendor Price 3")
        {
          ToolTip = 'Specifies the value of the Vendor Price 3 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No.4";Rec."RMT Vendor No.4")
        {
          ToolTip = 'Specifies the value of the Vendor No.4 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Price 4";Rec."RMT Vendor Price 4")
        {
          ToolTip = 'Specifies the value of the Vendor Price 4 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No.5";Rec."RMT Vendor No.5")
        {
          ToolTip = 'Specifies the value of the Vendor No.5 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Price 5";Rec."RMT Vendor Price 5")
        {
          ToolTip = 'Specifies the value of the Vendor Price 5 field';
          ApplicationArea = All;
        }
      }
    }
  }
  actions
  {
    area(processing)
    {
      action(SelectMultiItems)
      {
        AccessByPermission = TableData Item=R;
        ApplicationArea = Basic, Suite;
        Caption = 'Select items';
        Ellipsis = true;
        Image = NewItem;
        ToolTip = 'Add two or more items from the full list of your inventory items.';

        trigger OnAction()begin
          SelectMultipleItems();
        end;
      }
      group("F&unctions")
      {
        Caption = 'F&unctions';
        Image = "Action";

        action("E&xplode BOM")
        {
          AccessByPermission = TableData "BOM Component"=R;
          ApplicationArea = Suite;
          Caption = 'E&xplode BOM';
          Image = ExplodeBOM;
          Enabled = Type = Type::Item;
          ToolTip = 'Add a line for each component on the bill of materials for the selected item. For example, this is useful for selling the parent item as a kit. CAUTION: The line for the parent item will be deleted and only its description will display. To undo this action, delete the component lines and add a line for the parent item again. This action is available only for lines that contain an item.';

          trigger OnAction()begin
            ExplodeBOM();
          end;
        }
        action("Insert &Ext. Texts")
        {
          AccessByPermission = TableData "Extended Text Header"=R;
          ApplicationArea = Suite;
          Caption = 'Insert &Ext. Texts';
          Image = Text;
          ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

          trigger OnAction()begin
            InsertExtendedText(true);
          end;
        }
      }
      group("&Line")
      {
        Caption = '&Line';
        Image = Line;

        group("Item Availability by")
        {
          Caption = 'Item Availability by';
          Image = ItemAvailability;
          Enabled = Type = Type::Item;

          action("Event")
          {
            ApplicationArea = Basic, Suite;
            Caption = 'Event';
            Image = "Event";
            ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

            trigger OnAction()begin
              ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent)end;
          }
          action(Period)
          {
            ApplicationArea = Basic, Suite;
            Caption = 'Period';
            Image = Period;
            ToolTip = 'View the projected quantity of the item over time according to time periods, such as day, week, or month.';

            trigger OnAction()begin
              ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)end;
          }
          action(Variant)
          {
            ApplicationArea = Planning;
            Caption = 'Variant';
            Image = ItemVariant;
            ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

            trigger OnAction()begin
              ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)end;
          }
          action(Location)
          {
            AccessByPermission = TableData Location=R;
            ApplicationArea = Location;
            Caption = 'Location';
            Image = Warehouse;
            ToolTip = 'View the actual and projected quantity of the item per location.';

            trigger OnAction()begin
              ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)end;
          }
          // action(Lot)
          // {
          //     ApplicationArea = ItemTracking;
          //     Caption = 'Lot';
          //     Image = LotInfo;
          // //RunObject = Page "Item Availability by Lot No.";
          //     RunPageLink = "No." = field("No."),
          //         "Location Filter" = field("Location Code"),
          //         "Variant Filter" = field("Variant Code");
          //     ToolTip = 'View the current and projected quantity of the item in each lot.';
          // }
          action("BOM Level")
          {
            AccessByPermission = TableData "BOM Buffer"=R;
            ApplicationArea = Assembly;
            Caption = 'BOM Level';
            Image = BOMLevel;
            ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

            trigger OnAction()begin
              ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)end;
          }
        }
        action(Dimensions)
        {
          AccessByPermission = TableData Dimension=R;
          ApplicationArea = Suite;
          Caption = 'Dimensions';
          Image = Dimensions;
          ShortCutKey = 'Alt+D';
          ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

          trigger OnAction()begin
            ShowDimensions();
          end;
        }
        action("Co&mments")
        {
          ApplicationArea = Comments;
          Caption = 'Co&mments';
          Image = ViewComments;
          ToolTip = 'View or add comments for the record.';

          trigger OnAction()begin
            ShowLineComments();
          end;
        }
        action(ItemChargeAssignment)
        {
          AccessByPermission = TableData "Item Charge"=R;
          ApplicationArea = ItemCharges;
          Caption = 'Item Charge &Assignment';
          Image = ItemCosts;
          Enabled = Type = Type::"Charge (Item)";
          ToolTip = 'Record additional direct costs, for example for freight. This action is available only for Charge (Item) line types.';

          trigger OnAction()begin
            ShowItemChargeAssgnt();
            SetItemChargeFieldsStyle();
          end;
        }
        action("Item Tracking Lines")
        {
          ApplicationArea = ItemTracking;
          Caption = 'Item &Tracking Lines';
          Image = ItemTrackingLines;
          ShortCutKey = 'Shift+Ctrl+I';
          Enabled = Type = Type::Item;
          ToolTip = 'View or edit serial and lot numbers for the selected item. This action is available only for lines that contain an item.';

          trigger OnAction()begin
            OpenItemTrackingLines();
          end;
        }
        action(DocAttach)
        {
          ApplicationArea = All;
          Caption = 'Attachments';
          Image = Attach;
          ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

          trigger OnAction()var DocumentAttachmentDetails: Page "Document Attachment Details";
          RecRef: RecordRef;
          begin
            RecRef.GetTable(Rec);
            DocumentAttachmentDetails.OpenForRecRef(RecRef);
            DocumentAttachmentDetails.RunModal;
          end;
        }
      }
      group("Page")
      {
        Caption = 'Page';

        action(EditInExcel)
        {
          ApplicationArea = Basic, Suite;
          Caption = 'Edit in Excel';
          Image = Excel;
          Promoted = true;
          PromotedCategory = Category8;
          PromotedIsBig = true;
          PromotedOnly = true;
          Visible = IsSaaSExcelAddinEnabled;
          ToolTip = 'Send the data in the sub page to an Excel file for analysis or editing';
          AccessByPermission = System "Allow Action Export To Excel"=X;

          trigger OnAction()var ODataUtility: Codeunit ODataUtility;
          begin
            ODataUtility.EditWorksheetInExcel('Purchase_QuotePurchLines', CurrPage.ObjectId(false), StrSubstNo('Document_No eq ''%1''', Rec."Document No."));
          end;
        }
      }
    }
  }
  trigger OnAfterGetCurrRecord()begin
    GetTotalsPurchaseHeader();
    CalculateTotals();
    UpdateEditableOnRow();
    UpdateTypeText();
    SetItemChargeFieldsStyle();
  end;
  trigger OnAfterGetRecord()begin
    ShowShortcutDimCode(ShortcutDimCode);
    UpdateTypeText();
    SetItemChargeFieldsStyle();
  end;
  trigger OnDeleteRecord(): Boolean var PurchLineReserve: Codeunit "Purch. Line-Reserve";
  begin
    if(Quantity <> 0) and ItemExists("No.")then begin
      Commit();
      if not PurchLineReserve.DeleteLineConfirm(Rec)then exit(false);
      PurchLineReserve.DeleteLine(Rec);
    end;
    DocumentTotals.PurchaseDocTotalsNotUpToDate();
  end;
  trigger OnFindRecord(Which: Text): Boolean begin
    DocumentTotals.PurchaseCheckAndClearTotals(Rec, xRec, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
    exit(Find(Which));
  end;
  trigger OnInit()var ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
  begin
    PurchasesPayablesSetup.Get();
    "RMT Request for Quote":=true;
    //TempOptionLookupBuffer.FillLookupBuffer("Option Lookup Type"::Purchases);
    IsFoundation:=ApplicationAreaMgmtFacade.IsFoundationEnabled();
    Currency.InitRoundingPrecision();
  end;
  trigger OnModifyRecord(): Boolean begin
    DocumentTotals.PurchaseCheckIfDocumentChanged(Rec, xRec);
  end;
  trigger OnNewRecord(BelowxRec: Boolean)begin
    InitType();
    SetDefaultType();
    //PR PO
    SetupPurchaseRequest2();
    //PR PO
    Clear(ShortcutDimCode);
    UpdateTypeText();
  end;
  trigger OnOpenPage()var ServerSetting: Codeunit "Server Setting";
  begin
    IsSaaSExcelAddinEnabled:=ServerSetting.GetIsSaasExcelAddinEnabled();
    SuppressTotals:=CurrentClientType() = ClientType::ODataV4;
    SetDimensionsVisibility();
    SetItemReferenceVisibility();
  end;
  var Currency: Record Currency;
  PurchasesPayablesSetup: Record "Purchases & Payables Setup";
  //TempOptionLookupBuffer: Record "Option Lookup Buffer" temporary;
  ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
  TransferExtendedText: Codeunit "Transfer Extended Text";
  ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
  CannotUseBOMErr: Label 'You cannot use the Explode BOM function because a prepayment of the related purchase order has been invoiced.';
  PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
  DocumentTotals: Codeunit "Document Totals";
  AmountWithDiscountAllowed: Decimal;
  TypeAsText: Text[30];
  ItemChargeStyleExpression: Text;
  InvDiscAmountEditable: Boolean;
  IsFoundation: Boolean;
  IsSaaSExcelAddinEnabled: Boolean;
  UnitofMeasureCodeIsChangeable: Boolean;
  UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
  CurrPageIsEditable: Boolean;
  SuppressTotals: Boolean;
  [InDataSet]
  ItemReferenceVisible: Boolean;
  protected var TotalPurchaseHeader: Record "Purchase Header";
  TotalPurchaseLine: Record "Purchase Line";
  ShortcutDimCode: array[8]of Code[20];
  InvoiceDiscountAmount: Decimal;
  InvoiceDiscountPct: Decimal;
  VATAmount: Decimal;
  DimVisible1: Boolean;
  DimVisible2: Boolean;
  DimVisible3: Boolean;
  DimVisible4: Boolean;
  DimVisible5: Boolean;
  DimVisible6: Boolean;
  DimVisible7: Boolean;
  DimVisible8: Boolean;
  IsBlankNumber: Boolean;
  IsCommentLine: Boolean;
  procedure ApproveCalcInvDisc()begin
    CODEUNIT.Run(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    DocumentTotals.PurchaseDocTotalsNotUpToDate;
  end;
  local procedure ValidateInvoiceDiscountAmount()var PurchaseHeader: Record "Purchase Header";
  ConfirmManagement: Codeunit "Confirm Management";
  begin
    if SuppressTotals then exit;
    PurchaseHeader.Get("Document Type", "Document No.");
    if PurchaseHeader.InvoicedLineExists then if not ConfirmManagement.GetResponseOrDefault(UpdateInvDiscountQst, true)then exit;
    DocumentTotals.PurchaseDocTotalsNotUpToDate;
    PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchaseHeader);
    CurrPage.Update(false);
  end;
  local procedure ExplodeBOM()begin
    if "Prepmt. Amt. Inv." <> 0 then Error(CannotUseBOMErr);
    CODEUNIT.Run(CODEUNIT::"Purch.-Explode BOM", Rec);
    DocumentTotals.PurchaseDocTotalsNotUpToDate;
  end;
  procedure InsertExtendedText(Unconditionally: Boolean)var IsHandled: Boolean;
  begin
    IsHandled:=false;
    OnBeforeInsertExtendedText(Rec, IsHandled);
    if IsHandled then exit;
    if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally)then begin
      CurrPage.SaveRecord;
      TransferExtendedText.InsertPurchExtText(Rec);
    end;
    if TransferExtendedText.MakeUpdate then UpdateForm(true);
  end;
  procedure UpdateForm(SetSaveRecord: Boolean)begin
    CurrPage.Update(SetSaveRecord);
  end;
  procedure NoOnAfterValidate()begin
    UpdateEditableOnRow();
    InsertExtendedText(false);
    "RMT Request for Quote":=true;
    if(Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and (xRec."No." <> '')then CurrPage.SaveRecord;
    OnAfterNoOnAfterValidate(Rec, xRec);
  end;
  procedure RedistributeTotalsOnAfterValidate()begin
    if SuppressTotals then exit;
    CurrPage.SaveRecord;
    DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
    CurrPage.Update(false);
  end;
  local procedure GetTotalsPurchaseHeader()begin
    DocumentTotals.GetTotalPurchaseHeaderAndCurrency(Rec, TotalPurchaseHeader, Currency);
  end;
  procedure CalculateTotals()begin
    if SuppressTotals then exit;
    DocumentTotals.PurchaseCheckIfDocumentChanged(Rec, xRec);
    DocumentTotals.CalculatePurchaseSubPageTotals(TotalPurchaseHeader, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
    DocumentTotals.RefreshPurchaseLine(Rec);
  end;
  procedure DeltaUpdateTotals()begin
    if SuppressTotals then exit;
    DocumentTotals.PurchaseDeltaUpdateTotals(Rec, xRec, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
    CheckSendLineInvoiceDiscountResetNotification();
  end;
  local procedure CheckSendLineInvoiceDiscountResetNotification()var IsHandled: Boolean;
  begin
    IsHandled:=false;
    OnBeforeCheckSendLineInvoiceDiscountResetNotification(Rec, IsHandled);
    if IsHandled then exit;
    if "Line Amount" <> xRec."Line Amount" then SendLineInvoiceDiscountResetNotification();
  end;
  procedure UpdateEditableOnRow()begin
    IsCommentLine:=Type = Type::" ";
    IsBlankNumber:=IsCommentLine;
    UnitofMeasureCodeIsChangeable:=not IsCommentLine;
    CurrPageIsEditable:=CurrPage.Editable;
    InvDiscAmountEditable:=CurrPageIsEditable and not PurchasesPayablesSetup."Calc. Inv. Discount";
    OnAfterUpdateEditableOnRow(Rec, IsCommentLine, IsBlankNumber);
  end;
  procedure UpdateTypeText()var RecRef: RecordRef;
  begin
    if not IsFoundation then exit;
    OnBeforeUpdateTypeText(Rec);
    RecRef.GetTable(Rec);
  //TypeAsText := TempOptionLookupBuffer.FormatOption(RecRef.Field(FieldNo(Type)));
  end;
  local procedure SetItemChargeFieldsStyle()begin
    ItemChargeStyleExpression:='';
    if AssignedItemCharge and ("Qty. Assigned" <> Quantity)then ItemChargeStyleExpression:='Unfavorable';
  end;
  local procedure SetDimensionsVisibility()var DimMgt: Codeunit DimensionManagement;
  begin
    DimVisible1:=false;
    DimVisible2:=false;
    DimVisible3:=false;
    DimVisible4:=false;
    DimVisible5:=false;
    DimVisible6:=false;
    DimVisible7:=false;
    DimVisible8:=false;
    DimMgt.UseShortcutDims(DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);
    Clear(DimMgt);
  end;
  local procedure SetItemReferenceVisibility()var ItemReferenceMgt: Codeunit "Item Reference Management";
  begin
    ItemReferenceVisible:=ItemReferenceMgt.IsEnabled();
  end;
  local procedure SetDefaultType()var IsHandled: Boolean;
  begin
    IsHandled:=false;
    OnBeforeSetDefaultType(Rec, xRec, IsHandled);
    if not IsHandled then // Set default type Item
 if ApplicationAreaMgmtFacade.IsFoundationEnabled then if xRec."Document No." = '' then Type:=Type::Item;
  end;
  [IntegrationEvent(TRUE, false)]
  local procedure OnAfterNoOnAfterValidate(var PurchaseLine: Record "Purchase Line";
  var xPurchaseLine: Record "Purchase Line")begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnAfterUpdateEditableOnRow(PurchaseLine: Record "Purchase Line";
  var IsCommentLine: Boolean;
  var IsBlankNumber: Boolean);
  begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnAfterValidateShortcutDimCode(var PurchaseLine: Record "Purchase Line";
  var ShortcutDimCode: array[8]of Code[20];
  DimIndex: Integer)begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnBeforeInsertExtendedText(var PurchaseLine: Record "Purchase Line";
  var IsHandled: Boolean)begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnBeforeCheckSendLineInvoiceDiscountResetNotification(var PurchaseLine: Record "Purchase Line";
  var IsHandled: Boolean)begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnBeforeSetDefaultType(var PurchaseLine: Record "Purchase Line";
  var xPurchaseLine: Record "Purchase Line";
  var IsHandled: Boolean)begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnBeforeUpdateTypeText(var PurchaseLine: Record "Purchase Line")begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnItemReferenceNoOnLookup(var PurchaseLine: Record "Purchase Line")begin
  end;
}
