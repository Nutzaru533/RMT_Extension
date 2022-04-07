codeunit 50149 "RMT Even"
{
  trigger OnRun()begin
  end;
  // /// customize vat start
  // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeTestStatusOpen', '', true, true)]
  // local procedure "Purchase Line_OnBeforeTestStatusOpen"
  // (
  //     var PurchaseLine: Record "Purchase Line";
  //     var PurchaseHeader: Record "Purchase Header"
  // )
  // begin
  // end;
  // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnFillInvoicePostBufferOnAfterInitAmounts', '', true, true)]
  // local procedure "Purch.-Post_OnFillInvoicePostBufferOnAfterInitAmounts"
  // (
  //     PurchHeader: Record "Purchase Header";
  //     var PurchLine: Record "Purchase Line";
  //     var PurchLineACY: Record "Purchase Line";
  //     var TempInvoicePostBuffer: Record "Invoice Post. Buffer";
  //     var InvoicePostBuffer: Record "Invoice Post. Buffer";
  //     var TotalAmount: Decimal;
  //     var TotalAmountACY: Decimal
  // )
  // begin
  //     //Message('11');
  // end;
  // [EventSubscriber(ObjectType::Table, Database::"Invoice Post. Buffer", 'OnAfterInvPostBufferPreparePurchase', '', true, true)]
  // local procedure "Invoice Post. Buffer_OnAfterInvPostBufferPreparePurchase"
  // (
  //     var PurchaseLine: Record "Purchase Line";
  //     var InvoicePostBuffer: Record "Invoice Post. Buffer"
  // )
  // begin
  //     InvoicePostBuffer."Additional Grouping Identifier" := PurchaseLine."Tax Invoice No.";
  // end;
  // [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', true, true)]
  // local procedure "Purch. Rcpt. Line_OnBeforeInsertInvLineFromRcptLine"
  // (
  //     var PurchRcptLine: Record "Purch. Rcpt. Line";
  //     var PurchLine: Record "Purchase Line";
  //     PurchOrderLine: Record "Purchase Line";
  //     var IsHandled: Boolean
  // )
  // begin
  //     PurchaseHeader.reset;
  //     PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
  //     PurchaseHeader.SetRange("No.", PurchRcptLine."Order No.");
  //     if PurchaseHeader.Find('-') then begin
  //         PurchLine."Tax Invoice No." := PurchaseHeader."Vendor Invoice No.";
  //         PurchLine."Tax Invoice Date" := PurchaseHeader."Posting Date";
  //         PurchLine.Validate("Tax Vendor No.", PurchaseHeader."Pay-to Vendor No.");
  //         PurchLine."Tax Invoice Name" := PurchaseHeader."Pay-to Name";
  //     end;
  // end;
  // /// customize vat end
  var myInt: Integer;
  PurchaseHeader: Record "Purchase Header";
}
