codeunit 50148 "RMT Even PR to PO"
{
  trigger OnRun()begin
  end;
  [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateNoOnCopyFromTempPurchLine', '', true, true)]
  local procedure "Purchase Line_OnValidateNoOnCopyFromTempPurchLine"(var PurchLine: Record "Purchase Line";
  TempPurchaseLine: Record "Purchase Line")var PurchaseH: Record "Purchase Header";
  begin
    if PurchaseH.get(PurchLine."Document Type", PurchLine."Document No.")then begin
      PurchLine."RMT Purchase Request":=PurchaseH."RMT Purchase Request";
      PurchLine."RMT Request for Quote":=PurchaseH."RMT Request for Quote";
    end;
  end;
  var myInt: Integer;
}
