page 50108 "RMT RequestforQuote"
{
  Caption = 'Purchase Bidding Price';
  PageType = Document;
  PromotedActionCategories = 'New,Process,Report,Approve,Request Approval,Print/Send,Quote,Release,Navigate';
  RefreshOnActivate = true;
  SourceTable = "Purchase Header";
  SourceTableView = WHERE("Document Type"=CONST(Quote), "RMT Request for Quote"=filter(true));

  layout
  {
    area(content)
    {
      group(General)
      {
        Caption = 'General';

        field("No.";"No.")
        {
          ApplicationArea = Suite;
          Importance = Promoted;
          ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
          Visible = DocNoVisible;

          trigger OnAssistEdit()begin
            if AssistEditRequest2(xRec)then CurrPage.Update();
          end;
        }
        field("RMT Starting Date";"RMT Starting Date")
        {
          ApplicationArea = All;
        }
        field("RMT Ending Date";"RMT Ending Date")
        {
          ApplicationArea = All;
        }
        field("RMT Vendor No. 1";Rec."RMT Vendor No. 1")
        {
          ToolTip = 'Specifies the value of the Vendor No. 1 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 1";Rec."RMT Vendor Name 1")
        {
          ToolTip = 'Specifies the value of the Vendor Name 1 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No. 2";Rec."RMT Vendor No. 2")
        {
          ToolTip = 'Specifies the value of the Vendor No. 2 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 2";Rec."RMT Vendor Name 2")
        {
          ToolTip = 'Specifies the value of the Vendor Name 2 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No. 3";Rec."RMT Vendor No. 3")
        {
          ToolTip = 'Specifies the value of the Vendor No. 3 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 3";Rec."RMT Vendor Name 3")
        {
          ToolTip = 'Specifies the value of the Vendor Name 3 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No. 4";Rec."RMT Vendor No. 4")
        {
          ToolTip = 'Specifies the value of the Vendor No. 4 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 4";Rec."RMT Vendor Name 4")
        {
          ToolTip = 'Specifies the value of the Vendor Name 4 field';
          ApplicationArea = All;
        }
        field("RMT Vendor No. 5";Rec."RMT Vendor No. 5")
        {
          ToolTip = 'Specifies the value of the Vendor No. 5 field';
          ApplicationArea = All;
        }
        field("RMT Vendor Name 5";Rec."RMT Vendor Name 5")
        {
          ToolTip = 'Specifies the value of the Vendor Name 5 field';
          ApplicationArea = All;
        }
        field("Document Date";"Document Date")
        {
          ApplicationArea = Suite;
          ToolTip = 'Specifies the date when the related document was created.';
        }
        field(Status;Status)
        {
          ApplicationArea = Suite;
          Importance = Promoted;
          StyleExpr = StatusStyleTxt;
          ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
        }
        field("RMT Remark";"RMT Remark")
        {
          ApplicationArea = All;
        }
        field("Create By";"Create By")
        {
          ApplicationArea = All;
        }
      }
      part(PurchLines;"RMT RequestforQuote Subform")
      {
        ApplicationArea = Suite;
        Editable = "Buy-from Vendor No." <> '';
        Enabled = "Buy-from Vendor No." <> '';
        SubPageLink = "Document No."=FIELD("No.");
        UpdatePropagation = Both;
      }
    }
    area(factboxes)
    {
      part("Attached Documents";"Document Attachment Factbox")
      {
        ApplicationArea = All;
        Caption = 'Attachments';
        SubPageLink = "Table ID"=CONST(38), "No."=FIELD("No."), "Document Type"=FIELD("Document Type");
      }
      part(Control13;"Pending Approval FactBox")
      {
        ApplicationArea = Suite;
        SubPageLink = "Table ID"=CONST(38), "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
        Visible = OpenApprovalEntriesExistForCurrUser;
      }
      part(Control1901138007;"Vendor Details FactBox")
      {
        ApplicationArea = Suite;
        SubPageLink = "No."=FIELD("Buy-from Vendor No."), "Date Filter"=field("Date Filter");
        Visible = false;
      }
      part(Control1904651607;"Vendor Statistics FactBox")
      {
        ApplicationArea = Suite;
        SubPageLink = "No."=FIELD("Pay-to Vendor No."), "Date Filter"=field("Date Filter");
      }
      part(Control1903435607;"Vendor Hist. Buy-from FactBox")
      {
        ApplicationArea = Suite;
        SubPageLink = "No."=FIELD("Buy-from Vendor No."), "Date Filter"=field("Date Filter");
      }
      part(Control1906949207;"Vendor Hist. Pay-to FactBox")
      {
        ApplicationArea = Suite;
        SubPageLink = "No."=FIELD("Pay-to Vendor No."), "Date Filter"=field("Date Filter");
        Visible = false;
      }
      part(Control5;"Purchase Line FactBox")
      {
        ApplicationArea = Suite;
        Provider = PurchLines;
        SubPageLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("Document No."), "Line No."=FIELD("Line No.");
      }
      part(ApprovalFactBox;"Approval FactBox")
      {
        ApplicationArea = Suite;
        Visible = false;
      }
      part(IncomingDocAttachFactBox;"Incoming Doc. Attach. FactBox")
      {
        ApplicationArea = Suite;
        ShowFilter = false;
        Visible = false;
      }
      part(WorkflowStatus;"Workflow Status FactBox")
      {
        ApplicationArea = Suite;
        Editable = false;
        Enabled = false;
        ShowFilter = false;
        Visible = ShowWorkflowStatus;
      }
      systempart(Control1900383207;Links)
      {
        ApplicationArea = RecordLinks;
        Visible = false;
      }
      systempart(Control1905767507;Notes)
      {
        ApplicationArea = Notes;
      }
    }
  }
  actions
  {
    area(navigation)
    {
      group("&Quote")
      {
        Caption = '&Quote';
        Image = Quote;

        action(Statistics)
        {
          ApplicationArea = Suite;
          Caption = 'Statistics';
          Image = Statistics;
          Promoted = true;
          PromotedCategory = Category7;
          PromotedIsBig = true;
          ShortCutKey = 'F7';
          ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

          trigger OnAction()begin
            CalcInvDiscForHeader;
            Commit();
            PAGE.RunModal(PAGE::"Purchase Statistics", Rec);
            PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
          end;
        }
        action(Vendor)
        {
          ApplicationArea = Suite;
          Caption = 'Vendor';
          Enabled = "Buy-from Vendor No." <> '';
          Image = Vendor;
          Promoted = true;
          PromotedCategory = Category9;
          RunObject = Page "Vendor Card";
          RunPageLink = "No."=FIELD("Buy-from Vendor No."), "Date Filter"=FIELD("Date Filter");
          ShortCutKey = 'Shift+F7';
          ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
        }
        action("Co&mments")
        {
          ApplicationArea = Comments;
          Caption = 'Co&mments';
          Image = ViewComments;
          Promoted = true;
          PromotedCategory = Category7;
          RunObject = Page "Purch. Comment Sheet";
          RunPageLink = "Document Type"=FIELD("Document Type"), "No."=FIELD("No."), "Document Line No."=CONST(0);
          ToolTip = 'View or add comments for the record.';
        }
        action(Dimensions)
        {
          AccessByPermission = TableData Dimension=R;
          ApplicationArea = Dimensions;
          Caption = 'Dimensions';
          Enabled = "No." <> '';
          Image = Dimensions;
          Promoted = true;
          PromotedCategory = Category7;
          PromotedIsBig = true;
          ShortCutKey = 'Alt+D';
          ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

          trigger OnAction()begin
            ShowDocDim;
            CurrPage.SaveRecord;
          end;
        }
        action(Approvals)
        {
          AccessByPermission = TableData "Approval Entry"=R;
          ApplicationArea = Suite;
          Caption = 'Approvals';
          Image = Approvals;
          Promoted = true;
          PromotedCategory = Category7;
          ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

          trigger OnAction()var WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
          begin
            WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Purchase Header", "Document Type".AsInteger(), "No.");
          end;
        }
        action(DocAttach)
        {
          ApplicationArea = All;
          Caption = 'Attachments';
          Image = Attach;
          Promoted = true;
          PromotedCategory = Category7;
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
    }
    area(processing)
    {
      group(Approval)
      {
        Caption = 'Approval';

        action(Approve)
        {
          ApplicationArea = Suite;
          Caption = 'Approve';
          Image = Approve;
          Promoted = true;
          PromotedCategory = Category4;
          PromotedIsBig = true;
          PromotedOnly = true;
          ToolTip = 'Approve the requested changes.';
          Visible = OpenApprovalEntriesExistForCurrUser;

          trigger OnAction()var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
          begin
            ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
          end;
        }
        action(Reject)
        {
          ApplicationArea = Suite;
          Caption = 'Reject';
          Image = Reject;
          Promoted = true;
          PromotedCategory = Category4;
          PromotedIsBig = true;
          PromotedOnly = true;
          ToolTip = 'Reject to approve the incoming document.';
          Visible = OpenApprovalEntriesExistForCurrUser;

          trigger OnAction()var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
          begin
            ApprovalsMgmt.RejectRecordApprovalRequest(RecordId);
          end;
        }
        action(Delegate)
        {
          ApplicationArea = Suite;
          Caption = 'Delegate';
          Image = Delegate;
          Promoted = true;
          PromotedCategory = Category4;
          PromotedOnly = true;
          ToolTip = 'Delegate the approval to a substitute approver.';
          Visible = OpenApprovalEntriesExistForCurrUser;

          trigger OnAction()var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
          begin
            ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId);
          end;
        }
        action(Comment)
        {
          ApplicationArea = Suite;
          Caption = 'Comments';
          Image = ViewComments;
          Promoted = true;
          PromotedCategory = Category4;
          PromotedOnly = true;
          ToolTip = 'View or add comments for the record.';
          Visible = OpenApprovalEntriesExistForCurrUser;

          trigger OnAction()var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
          begin
            ApprovalsMgmt.GetApprovalComment(Rec);
          end;
        }
      }
      group(Action92)
      {
        Caption = 'Print';

        action(Print)
        {
          ApplicationArea = Suite;
          Caption = '&Print';
          Ellipsis = true;
          Image = Print;
          Promoted = true;
          PromotedCategory = Category6;
          ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

          trigger OnAction()var LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
          begin
            if ApplicationAreaMgmtFacade.IsFoundationEnabled then LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);
            DocPrint.PrintPurchHeader(Rec);
          end;
        }
        action(Send)
        {
          ApplicationArea = Basic, Suite;
          Caption = 'Send';
          Ellipsis = true;
          Image = SendToMultiple;
          Promoted = true;
          PromotedCategory = Category6;
          ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

          trigger OnAction()var PurchaseHeader: Record "Purchase Header";
          begin
            PurchaseHeader:=Rec;
            CurrPage.SetSelectionFilter(PurchaseHeader);
            PurchaseHeader.SendRecords;
          end;
        }
        action(AttachAsPDF)
        {
          ApplicationArea = Basic, Suite;
          Caption = 'Attach as PDF';
          Image = PrintAttachment;
          Promoted = true;
          PromotedCategory = Category6;
          PromotedIsBig = true;
          PromotedOnly = true;
          ToolTip = 'Create a PDF file and attach it to the document.';

          trigger OnAction()var PurchaseHeader: Record "Purchase Header";
          begin
            PurchaseHeader:=Rec;
            PurchaseHeader.SetRecFilter();
            DocPrint.PrintPurchaseHeaderToDocumentAttachment(PurchaseHeader);
          end;
        }
      }
      group(Action3)
      {
        Caption = 'Release';
        Image = ReleaseDoc;

        separator(Action148)
        {
        }
        action(Release)
        {
          ApplicationArea = Suite;
          Caption = 'Re&lease';
          Image = ReleaseDoc;
          Promoted = true;
          PromotedCategory = Category8;
          PromotedIsBig = true;
          PromotedOnly = true;
          ShortCutKey = 'Ctrl+F9';
          ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

          trigger OnAction()var ReleasePurchDoc: Codeunit "Release Purchase Document";
          PurchaseLine: Record "Purchase Line";
          begin
            //check
            PurchaseLine.reset;
            PurchaseLine.SetRange("Document No.", "No.");
            PurchaseLine.SetRange("Document Type", "Document Type");
            if PurchaseLine.Find('-')then begin
              repeat PurchaseLine.TestField("RMT Selected Vendor No.");
              until PurchaseLine.Next() = 0;
            end;
            //check
            ReleasePurchDoc.PerformManualRelease(Rec);
          end;
        }
        action(Reopen)
        {
          ApplicationArea = Suite;
          Caption = 'Re&open';
          Enabled = Status <> Status::Open;
          Image = ReOpen;
          Promoted = true;
          PromotedCategory = Category8;
          PromotedOnly = true;
          ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

          trigger OnAction()var ReleasePurchDoc: Codeunit "Release Purchase Document";
          begin
            ReleasePurchDoc.PerformManualReopen(Rec);
          end;
        }
      }
      group("F&unctions")
      {
        Caption = 'F&unctions';
        Image = "Action";

        action(CalculateInvoiceDiscount)
        {
          AccessByPermission = TableData "Vendor Invoice Disc."=R;
          ApplicationArea = Suite;
          Caption = 'Calculate &Invoice Discount';
          Image = CalculateInvoiceDiscount;
          ToolTip = 'Calculate the invoice discount for the purchase quote.';

          trigger OnAction()begin
            ApproveCalcInvDisc;
            PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
          end;
        }
        separator(Action144)
        {
        }
        action("Get St&d. Vend. Purchase Codes")
        {
          ApplicationArea = Suite;
          Caption = 'Get St&d. Vend. Purchase Codes';
          Ellipsis = true;
          Image = VendorCode;
          ToolTip = 'View a list of the standard purchase lines that have been assigned to the vendor to be used for recurring purchases.';

          trigger OnAction()var StdVendPurchCode: Record "Standard Vendor Purchase Code";
          begin
            StdVendPurchCode.InsertPurchLines(Rec);
          end;
        }
        separator(Action146)
        {
        }
        action(CopyDocument)
        {
          ApplicationArea = Suite;
          Caption = 'Copy Document';
          Ellipsis = true;
          Enabled = "No." <> '';
          Image = CopyDocument;
          Promoted = true;
          PromotedCategory = Process;
          ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

          trigger OnAction()begin
            CopyDocument();
            if Get("Document Type", "No.")then;
          end;
        }
        action(GetbestPrice)
        {
          ApplicationArea = Suite;
          Caption = 'Get Best Price';
          Ellipsis = true;
          Enabled = "No." <> '';
          Image = GetEntries;
          Promoted = true;
          PromotedCategory = Process;
          ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

          trigger OnAction()var PurchaseLine: Record "Purchase Line";
          begin
            PurchaseLine.reset;
            PurchaseLine.SetRange("Document Type", "Document Type");
            PurchaseLine.SetRange("Document No.", "No.");
            if PurchaseLine.Find('-')then begin
              PurchaseLine.GetBestPrice(PurchaseLine);
            end;
          end;
        }
        action("Archive Document")
        {
          ApplicationArea = Suite;
          Caption = 'Archi&ve Document';
          Image = Archive;
          ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';

          trigger OnAction()begin
            ArchiveManagement.ArchivePurchDocument(Rec);
            CurrPage.Update(false);
          end;
        }
        group(IncomingDocument)
        {
          Caption = 'Incoming Document';
          Image = Documents;

          action(IncomingDocCard)
          {
            ApplicationArea = Suite;
            Caption = 'View Incoming Document';
            Enabled = HasIncomingDocument;
            Image = ViewOrder;
            ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

            trigger OnAction()var IncomingDocument: Record "Incoming Document";
            begin
              IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
            end;
          }
          action(SelectIncomingDoc)
          {
            AccessByPermission = TableData "Incoming Document"=R;
            ApplicationArea = Suite;
            Caption = 'Select Incoming Document';
            Image = SelectLineToApply;
            ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

            trigger OnAction()var IncomingDocument: Record "Incoming Document";
            begin
              Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.", RecordId));
            end;
          }
          action(IncomingDocAttachFile)
          {
            ApplicationArea = Suite;
            Caption = 'Create Incoming Document from File';
            Ellipsis = true;
            Enabled = ("Incoming Document Entry No." = 0) AND ("No." <> '');
            Image = Attach;
            ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

            trigger OnAction()var IncomingDocumentAttachment: Record "Incoming Document Attachment";
            begin
              IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
            end;
          }
          action(RemoveIncomingDoc)
          {
            ApplicationArea = Suite;
            Caption = 'Remove Incoming Document';
            Enabled = HasIncomingDocument;
            Image = RemoveLine;
            ToolTip = 'Remove any incoming document records and file attachments.';

            trigger OnAction()var IncomingDocument: Record "Incoming Document";
            begin
              if IncomingDocument.Get("Incoming Document Entry No.")then IncomingDocument.RemoveLinkToRelatedRecord;
              "Incoming Document Entry No.":=0;
              Modify(true);
            end;
          }
        }
      }
      group("Request Approval")
      {
        Caption = 'Request Approval';

        action(SendApprovalRequest)
        {
          ApplicationArea = Basic, Suite;
          Caption = 'Send A&pproval Request';
          Enabled = NOT OpenApprovalEntriesExist;
          Image = SendApprovalRequest;
          Promoted = true;
          PromotedCategory = Category5;
          PromotedIsBig = true;
          ToolTip = 'Request approval of the document.';

          trigger OnAction()var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
          begin
            if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec)then ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
          end;
        }
        action(CancelApprovalRequest)
        {
          ApplicationArea = Basic, Suite;
          Caption = 'Cancel Approval Re&quest';
          Enabled = CanCancelApprovalForRecord;
          Image = CancelApprovalRequest;
          Promoted = true;
          PromotedCategory = Category5;
          ToolTip = 'Cancel the approval request.';

          trigger OnAction()var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
          begin
            ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
          end;
        }
      }
      group("Make Order")
      {
        Caption = 'Make Order';
        Image = MakeOrder;

        action(MakeOrder)
        {
          ApplicationArea = Suite;
          Caption = 'Make &Order';
          Image = MakeOrder;
          Promoted = true;
          PromotedCategory = Process;
          PromotedIsBig = true;
          ToolTip = 'Convert the purchase quote to a purchase order.';

          trigger OnAction()var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
          begin
            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec)then CODEUNIT.Run(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec);
          end;
        }
      }
      action(PurchaseComparePriceReport)
      {
        ApplicationArea = Suite;
        Caption = 'Purchase Compare Price';
        Image = MakeOrder;
        Promoted = true;
        PromotedCategory = Process;
        PromotedIsBig = true;
        ToolTip = 'Convert the purchase quote to a purchase order.';

        trigger OnAction()var PurchaseHeader: Record "Purchase Header";
        begin
          PurchaseHeader.reset;
          PurchaseHeader.SetRange("Document Type", rec."Document Type");
          PurchaseHeader.SetRange("No.", rec."No.");
          report.RunModal(report::"RMT Purchase Compare Price", true, true, PurchaseHeader);
        end;
      }
    }
  }
  trigger OnAfterGetCurrRecord()begin
    SetControlAppearance;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RecordId);
    ShowWorkflowStatus:=CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RecordId);
    StatusStyleTxt:=GetStatusStyleText();
  end;
  trigger OnAfterGetRecord()begin
    CalculateCurrentShippingAndPayToOption;
    if BuyFromContact.Get("Buy-from Contact No.")then;
    if PayToContact.Get("Pay-to Contact No.")then;
  end;
  trigger OnDeleteRecord(): Boolean begin
    CurrPage.SaveRecord;
    exit(ConfirmDeletion);
  end;
  trigger OnInit()begin
    ShowShippingOptionsWithLocation:=ApplicationAreaMgmtFacade.IsLocationEnabled or ApplicationAreaMgmtFacade.IsAllDisabled;
  end;
  trigger OnNewRecord(BelowxRec: Boolean)begin
    "Responsibility Center":=UserMgt.GetPurchasesFilter;
    if(not DocNoVisible) and ("No." = '')then SetBuyFromVendorFromFilter;
    CalculateCurrentShippingAndPayToOption;
  end;
  trigger OnOpenPage()begin
    if UserMgt.GetPurchasesFilter <> '' then begin
      FilterGroup(2);
      SetRange("Responsibility Center", UserMgt.GetPurchasesFilter);
      FilterGroup(0);
    end;
    SetRange("Date Filter", 0D, WorkDate());
    ActivateFields;
    SetDocNoVisible;
  end;
  var BuyFromContact: Record Contact;
  PayToContact: Record Contact;
  ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
  DocPrint: Codeunit "Document-Print";
  UserMgt: Codeunit "User Setup Management";
  ArchiveManagement: Codeunit ArchiveManagement;
  PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
  FormatAddress: Codeunit "Format Address";
  ChangeExchangeRate: Page "Change Exchange Rate";
  [InDataSet]
  StatusStyleTxt: Text;
  HasIncomingDocument: Boolean;
  DocNoVisible: Boolean;
  OpenApprovalEntriesExistForCurrUser: Boolean;
  OpenApprovalEntriesExist: Boolean;
  ShowWorkflowStatus: Boolean;
  CanCancelApprovalForRecord: Boolean;
  ShowShippingOptionsWithLocation: Boolean;
  IsBuyFromCountyVisible: Boolean;
  IsPayToCountyVisible: Boolean;
  IsShipToCountyVisible: Boolean;
  protected var ShipToOptions: Option "Default (Company Address)", Location, "Custom Address";
  PayToOptions: Option "Default (Vendor)", "Another Vendor", "Custom Address";
  protected procedure ActivateFields()begin
    IsBuyFromCountyVisible:=FormatAddress.UseCounty("Buy-from Country/Region Code");
    IsPayToCountyVisible:=FormatAddress.UseCounty("Pay-to Country/Region Code");
    IsShipToCountyVisible:=FormatAddress.UseCounty("Ship-to Country/Region Code");
    OnAfterActivateFields();
  end;
  local procedure ApproveCalcInvDisc()begin
    CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
  end;
  local procedure SaveInvoiceDiscountAmount()var DocumentTotals: Codeunit "Document Totals";
  begin
    CurrPage.SaveRecord;
    DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
    CurrPage.Update(false);
  end;
  local procedure PurchaserCodeOnAfterValidate()begin
    CurrPage.PurchLines.PAGE.UpdateForm(true);
  end;
  local procedure ShortcutDimension1CodeOnAfterV()begin
    CurrPage.Update();
  end;
  local procedure ShortcutDimension2CodeOnAfterV()begin
    CurrPage.Update();
  end;
  local procedure PricesIncludingVATOnAfterValid()begin
    CurrPage.Update();
  end;
  local procedure SetDocNoVisible()var DocumentNoVisibility: Codeunit DocumentNoVisibility;
  DocType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", Reminder, FinChMemo;
  begin
    DocNoVisible:=DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Quote, "No.");
  end;
  local procedure SetControlAppearance()var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
  begin
    OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
    OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
    CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
    HasIncomingDocument:="Incoming Document Entry No." <> 0;
  end;
  local procedure ValidateShippingOption()begin
    OnBeforeValidateShipToOptions(Rec, ShipToOptions);
    case ShipToOptions of ShipToOptions::"Default (Company Address)", ShipToOptions::"Custom Address": Validate("Location Code", '');
    ShipToOptions::Location: Validate("Location Code");
    end;
    OnAfterValidateShipToOptions(Rec, ShipToOptions);
  end;
  local procedure CalculateCurrentShippingAndPayToOption()begin
    if "Location Code" <> '' then ShipToOptions:=ShipToOptions::Location
    else if ShipToAddressEqualsCompanyShipToAddress then ShipToOptions:=ShipToOptions::"Default (Company Address)"
      else
        ShipToOptions:=ShipToOptions::"Custom Address";
    case true of("Pay-to Vendor No." = "Buy-from Vendor No.") and BuyFromAddressEqualsPayToAddress: PayToOptions:=PayToOptions::"Default (Vendor)";
    ("Pay-to Vendor No." = "Buy-from Vendor No.") and (not BuyFromAddressEqualsPayToAddress): PayToOptions:=PayToOptions::"Custom Address";
    "Pay-to Vendor No." <> "Buy-from Vendor No.": PayToOptions:=PayToOptions::"Another Vendor";
    end;
    OnAfterCalculateCurrentShippingAndPayToOption(ShipToOptions, PayToOptions, Rec);
  end;
  [IntegrationEvent(true, false)]
  local procedure OnAfterActivateFields()begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnAfterCalculateCurrentShippingAndPayToOption(var ShipToOptions: Option "Default (Company Address)", Location, "Custom Address";
  var PayToOptions: Option "Default (Vendor)", "Another Vendor", "Custom Address";
  PurchaseHeader: Record "Purchase Header")begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnBeforeValidateShipToOptions(var PurchaseHeader: Record "Purchase Header";
  ShipToOptions: Option)begin
  end;
  [IntegrationEvent(false, false)]
  local procedure OnAfterValidateShipToOptions(var PurchaseHeader: Record "Purchase Header";
  ShipToOptions: Option)begin
  end;
}
