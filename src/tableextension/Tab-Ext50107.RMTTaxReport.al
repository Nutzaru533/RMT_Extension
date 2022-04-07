tableextension 50107 "RMT Tax Report" extends "Tax Report Line"
{
  fields
  {
  }
  var myInt: Integer;
  procedure "GetVatData2"()var VatTransection: Record "VAT Transections";
  TaxReportHeader: Record "Tax Report Header";
  TaxReportLine: Record "Tax Report Line";
  TaxReportLineFind: Record "Tax Report Line";
  VATProdPostingGroup: Record "VAT Product Posting Group";
  var_Skip: Boolean;
  PurchaseCN: Record "Purch. Cr. Memo Hdr.";
  PurchaseCNLine: Record "Purch. Cr. Memo Line";
  PurchaseINvoice: Record "Purch. Inv. Header";
  PurchaseInvoiceLine: Record "Purch. Inv. Line";
  SalesCN: Record "Sales Cr.Memo Header";
  SalesInvoice: Record "Sales Invoice Header";
  VarPostingGroup: Record "VAT Product Posting Group";
  varPostingSsetup: Record "VAT Posting Setup";
  vatEntry: Record "VAT Entry";
  checkrevers: Boolean;
  VendorLedger: Record "Vendor Ledger Entry";
  VendorDetail: Record "Detailed Vendor Ledg. Entry";
  VatAmt, VatBase: Decimal;
  TaxInvoiceNo: Code[30];
  TaxINvoiceLine: Integer;
  begin
    TaxReportHeader.get("Tax Type", "Document No.");
    TaxReportHeader.TestField("End date of Month");
    VatTransection.reset;
    VatTransection.SetRange("Type", "Tax Type" + 1);
    VatTransection.SetFilter("Posting Date", '%1..%2', DMY2Date(01, TaxReportHeader."Month No.", TaxReportHeader."Year No."), CalcDate('<CM>', TaxReportHeader."End date of Month"));
    // if "Tax Type" = "Tax Type"::Sale then begin
    //     VatTransection.SETFILTER("VAT Bus. Posting Group", '<>NOVAT');
    //     VatTransection.SETFILTER("VAT Prod. Posting Group", '%1|%2', 'VAT7', 'DIRECT');
    // end else begin
    //     VatTransection.SETFILTER("VAT Prod. Posting Group", '<>%1', '');
    //     VatTransection.SETFILTER("Base", '<>%1', 0);
    // end;
    VatTransection.SetRange("Get to Tax", false);
    if VatTransection.FindSet()then repeat if not varPostingSsetup.GET(VatTransection."VAT Bus. Posting Group", VatTransection."VAT Prod. Posting Group")then varPostingSsetup.init;
        var_Skip:=false;
        checkrevers:=false;
        if VatTransection."Document Type" <> VatTransection."Document Type"::Payment then begin
          if VatTransection."Type" = VatTransection."Type"::Purchase then begin
            if varPostingSsetup."Unrealized VAT Type" = varPostingSsetup."Unrealized VAT Type"::Percentage then begin
              VendorLedger.reset;
              VendorLedger.SetRange("Document No.", VatTransection."Document No.");
              if VendorLedger.FindFirst()then begin
                VendorDetail.reset;
                VendorDetail.SetRange("Vendor Ledger Entry No.", VendorLedger."Entry No.");
                VendorDetail.SetRange("Document Type", VendorDetail."Document Type"::Payment);
                if VendorDetail.FindFirst()then checkrevers:=true;
              end;
            end;
          end;
        end;
        var_Skip:=checkrevers;
        if not checkrevers then begin
          if not VATProdPostingGroup.Get(VatTransection."VAT Prod. Posting Group")then VATProdPostingGroup.init;
          if VatTransection."Type" = VatTransection."Type"::Purchase then begin
            if varPostingSsetup."Generate Purch. Vat Report" then var_Skip:=false;
            IF VATProdPostingGroup."Direct VAT" THEN BEGIN
              IF(VatTransection."Tax Invoice Base" = 0)THEN var_Skip:=TRUE;
            END
            ELSE
            BEGIN
              IF(VatTransection."Base" = 0) OR (VatTransection."Amount" = 0)THEN var_Skip:=TRUE;
            END;
            if NOT varPostingSsetup."Generate Purch. Vat Report" then var_Skip:=true;
          end;
          if VatTransection."Type" = VatTransection."Type"::Sale then begin
            if NOT varPostingSsetup."Generate Sales Vat Report" then var_Skip:=true;
          end;
        end;
        if not var_Skip then begin
          TaxReportLineFind.RESET;
          TaxReportLineFind.SETFILTER("Tax Type", '%1', "Tax Type");
          TaxReportLineFind.SETFILTER("Voucher No.", '%1', VatTransection."Document No.");
          TaxReportLineFind.SETFILTER("Tax Invoice No.", '%1', VatTransection."Tax Invoice No.");
          IF TaxReportLineFind.FindFirst()THEN BEGIN
            VarPostingGroup.GET(VatTransection."VAT Prod. Posting Group");
            if VatTransection."Document Type" = VatTransection."Document Type"::Invoice then begin
              if varPostingSsetup."Unrealized VAT Type" <> varPostingSsetup."Unrealized VAT Type"::Percentage then begin
                TaxReportLineFind."Base Amount"+=ABS(VatTransection."Base");
                TaxReportLineFind."VAT Amount"+=ABS(VatTransection."Amount");
              end
              else
              begin
                TaxReportLineFind."Base Amount"+=ABS(VatTransection."Remaining Unrealized Base");
                TaxReportLineFind."VAT Amount"+=ABS(VatTransection."Remaining Unrealized Amt.");
              end;
            end
            else
            begin
              if VatTransection."Document Type" = VatTransection."Document Type"::"Credit Memo" then begin
                if varPostingSsetup."Unrealized VAT Type" <> varPostingSsetup."Unrealized VAT Type"::Percentage then begin
                  TaxReportLineFind."Base Amount"+=ABS(VatTransection."Base") * -1;
                  TaxReportLineFind."VAT Amount"+=ABS(VatTransection."Amount") * -1;
                end
                else
                begin
                  TaxReportLineFind."Base Amount"+=ABS(VatTransection."Remaining Unrealized Base") * -1;
                  TaxReportLineFind."VAT Amount"+=ABS(VatTransection."Remaining Unrealized Amt.") * -1;
                end;
              end
              else
              begin
                if(VATProdPostingGroup."Direct VAT") and (VatTransection."Document Type" = VatTransection."Document Type"::" ")then begin
                  TaxReportLineFind."Base Amount"+=VatTransection."Tax Invoice Base";
                  TaxReportLineFind."VAT Amount"+=VatTransection."Tax Invoice Amount";
                end
                else
                begin
                  TaxReportLineFind."Base Amount"+=ABS(VatTransection."Base");
                  TaxReportLineFind."VAT Amount"+=ABS(VatTransection."Amount");
                end;
              end;
            end;
            IF VatTransection."Amount" = 0 THEN TaxReportLineFind."Base Amount VAT0"+=TaxReportLineFind."Base Amount"
            ELSE
              TaxReportLineFind."Base Amount VAT7"+=TaxReportLineFind."VAT Amount";
            TaxReportLineFind.Modify();
          end
          else
          begin
            TaxReportLine.INIT;
            TaxReportLine."Tax Type":="Tax Type";
            TaxReportLine."Document No.":="Document No.";
            TaxReportLine."Entry No.":="GetLastLineNo";
            TaxReportLine."Posting Date":=VatTransection."Posting Date";
            TaxReportLine."Voucher No.":=VatTransection."Document No.";
            TaxReportLine."VAT Business Posting Group":=VatTransection."VAT Bus. Posting Group";
            TaxReportLine."VAT Product Posting Group":=VatTransection."VAT Prod. Posting Group";
            TaxReportLine."Tax Invoice Date":=VatTransection."Tax Invoice Date";
            if VatTransection."Document Type" = VatTransection."Document Type"::Invoice then begin
              TaxReportLine."Base Amount":=ABS(VatTransection."Base");
              TaxReportLine."VAT Amount":=ABS(VatTransection."Amount");
            end
            else
            begin
              if VatTransection."Document Type" = VatTransection."Document Type"::"Credit Memo" then begin
                TaxReportLine."Base Amount":=ABS(VatTransection."Base") * -1;
                TaxReportLine."VAT Amount":=ABS(VatTransection."Amount") * -1;
              end
              else
              begin
                TaxReportLine."Base Amount":=ABS(VatTransection."Base");
                TaxReportLine."VAT Amount":=ABS(VatTransection."Amount");
              end;
            end;
            "OnBeforeInsertVatLine"(TaxReportLine, VatTransection);
            if(VatTransection."Tax Invoice No." <> '')then begin
              TaxReportLine."Tax Invoice No.":=VatTransection."Tax Invoice No.";
              TaxReportLine."Tax Invoice Name":=VatTransection."Tax Invoice Name";
              TaxReportLine."Vendor No.":=VatTransection."Tax Vendor No.";
              if VatTransection."Type" = VatTransection."Type"::Sale then TaxReportLine."Customer No.":=VatTransection."Bill-to/Pay-to No.";
              IF(VatTransection.Type <> VatTransection.Type::Sale)then begin
                if VatTransection."Document Type" = VatTransection."Document Type"::Invoice then begin
                  PurchaseInvoiceLine.GET(VatTransection."Document No.", VatTransection."Document Line No.");
                  if PurchaseInvoiceLine."Tax Invoice No." <> '' then begin
                    if varPostingSsetup."Unrealized VAT Type" <> varPostingSsetup."Unrealized VAT Type"::Percentage then begin
                    //TaxReportLine."Base Amount" := ABS(VatTransection."Tax Invoice Base");
                    //TaxReportLine."VAT Amount" := ABS(VatTransection."Tax Invoice Amount");
                    end
                    else
                    begin
                      TaxReportLine."Base Amount":=ABS(VatTransection."Remaining Unrealized Base");
                      TaxReportLine."VAT Amount":=ABS(VatTransection."Remaining Unrealized Amt.");
                    end;
                  end
                  else
                  begin
                    if varPostingSsetup."Unrealized VAT Type" <> varPostingSsetup."Unrealized VAT Type"::Percentage then begin
                      if VatTransection."Base" = 0 then TaxReportLine."Base Amount":=ABS(VatTransection."Tax Invoice Base")
                      else
                        TaxReportLine."Base Amount":=ABS(VatTransection."Base");
                      if ABS(VatTransection."Amount") = 0 then TaxReportLine."VAT Amount":=ABS(VatTransection."Tax Invoice Amount")
                      else
                        TaxReportLine."VAT Amount":=ABS(VatTransection."Amount");
                    end
                    else
                    begin
                      TaxReportLine."Base Amount":=ABS(VatTransection."Remaining Unrealized Base");
                      TaxReportLine."VAT Amount":=ABS(VatTransection."Remaining Unrealized Amt.");
                    end;
                  end;
                end
                else
                begin
                  if VatTransection."Document Type" = VatTransection."Document Type"::"Credit Memo" then begin
                    PurchaseCNLine.GET(VatTransection."Document No.", VatTransection."Document Line No.");
                    if PurchaseCNLine."Tax Invoice No." <> '' then begin
                      if varPostingSsetup."Unrealized VAT Type" <> varPostingSsetup."Unrealized VAT Type"::Percentage then begin
                        TaxReportLine."Base Amount":=ABS(VatTransection."Tax Invoice Base") * -1;
                        TaxReportLine."VAT Amount":=ABS(VatTransection."Tax Invoice Amount") * -1;
                      end
                      else
                      begin
                        TaxReportLine."Base Amount":=ABS(VatTransection."Remaining Unrealized Base") * -1;
                        TaxReportLine."VAT Amount":=ABS(VatTransection."Remaining Unrealized Amt.") * -1;
                      end;
                    end
                    else
                    begin
                      if varPostingSsetup."Unrealized VAT Type" <> varPostingSsetup."Unrealized VAT Type"::Percentage then begin
                        if VatTransection."Base" = 0 then TaxReportLine."Base Amount":=ABS(VatTransection."Tax Invoice Base") * -1
                        else
                          TaxReportLine."Base Amount":=ABS(VatTransection."Base") * -1;
                        if ABS(VatTransection."Amount") = 0 then TaxReportLine."VAT Amount":=ABS(VatTransection."Tax Invoice Amount") * -1
                        else
                          TaxReportLine."VAT Amount":=ABS(VatTransection."Amount") * -1;
                      end
                      else
                      begin
                        TaxReportLine."Base Amount":=ABS(VatTransection."Remaining Unrealized Base") * -1;
                        TaxReportLine."VAT Amount":=ABS(VatTransection."Remaining Unrealized Amt.") * -1;
                      end;
                    end;
                  end;
                end;
              end;
            end
            else
            begin
              TaxReportLine."Tax Invoice No.":=VatTransection."External Document No.";
              IF VatTransection."Type" = VatTransection."Type"::Purchase THEN begin
                TaxReportLine."Vendor No.":=VatTransection."Bill-to/Pay-to No.";
                if VatTransection."Document Type" = VatTransection."Document Type"::"Credit Memo" then begin
                  if not PurchaseCN.GET(VatTransection."Document No.")then PurchaseCN.init;
                  TaxReportLine."Tax Invoice Name":=PurchaseCN."Buy-from Vendor Name" + ' ' + PurchaseCN."Buy-from Vendor Name 2";
                end
                else
                begin
                  if not PurchaseINvoice.GET(VatTransection."Document No.")then PurchaseINvoice.init;
                  TaxReportLine."Tax Invoice Name":=PurchaseINvoice."Buy-from Vendor Name" + ' ' + PurchaseINvoice."Buy-from Vendor Name 2";
                end;
              end
              ELSE
              begin
                TaxReportLine."Customer No.":=VatTransection."Bill-to/Pay-to No.";
                if VatTransection."Document Type" = VatTransection."Document Type"::"Credit Memo" then begin
                  if not SalesCN.GET(VatTransection."Document No.")then SalesCN.init;
                  TaxReportLine."Tax Invoice Name":=SalesCN."Sell-to Customer Name" + ' ' + SalesCN."Sell-to Customer Name 2";
                  if varPostingSsetup."Unrealized VAT Type" <> varPostingSsetup."Unrealized VAT Type"::Percentage then begin
                    TaxReportLine."Base Amount":=ABS(VatTransection."Base") * -1;
                    TaxReportLine."VAT Amount":=ABS(VatTransection."Amount") * -1;
                  end
                  else
                  begin
                    TaxReportLine."Base Amount":=ABS(VatTransection."Remaining Unrealized Base") * -1;
                    TaxReportLine."VAT Amount":=ABS(VatTransection."Remaining Unrealized Amt.") * -1;
                  end;
                end
                else
                begin
                  if not SalesInvoice.GET(VatTransection."Document No.")then SalesInvoice.init;
                  TaxReportLine."Tax Invoice Name":=SalesInvoice."Sell-to Customer Name" + ' ' + SalesInvoice."Sell-to Customer Name 2";
                  if varPostingSsetup."Unrealized VAT Type" <> varPostingSsetup."Unrealized VAT Type"::Percentage then begin
                    TaxReportLine."Base Amount":=ABS(VatTransection."Base");
                    TaxReportLine."VAT Amount":=ABS(VatTransection."Amount");
                  end
                  else
                  begin
                    TaxReportLine."Base Amount":=ABS(VatTransection."Remaining Unrealized Base");
                    TaxReportLine."VAT Amount":=ABS(VatTransection."Remaining Unrealized Amt.");
                  end;
                end;
              end;
            end;
            if(VatTransection."Type" = VatTransection."Type"::Purchase) AND (VatTransection."Document Type" = VatTransection."Document Type"::Payment)then begin
              VendorLedger.reset;
              VendorLedger.SetRange("Document No.", VatTransection."Document No.");
              if VendorLedger.FindFirst()then TaxReportLine."Tax Invoice No.":=VendorLedger."External Document No.";
            end;
            if(VATProdPostingGroup."Direct VAT") and (VatTransection."Document Type" = VatTransection."Document Type"::" ")then begin
              TaxReportLine."Base Amount":=VatTransection."Tax Invoice Base";
              TaxReportLine."VAT Amount":=VatTransection."Tax Invoice Amount";
            end;
            TaxReportLine."Head Office":=VatTransection."Head Office";
            TaxReportLine."Branch Code":=VatTransection."Branch Code";
            TaxReportLine."VAT Registration No.":=VatTransection."VAT Registration No.";
            TaxReportLine."Description":=VatTransection."Description Line";
            TaxReportLine."Send to Report":=true;
            TaxReportLine."Ref. Entry No.":=VatTransection."Entry No.";
            IF VatTransection."Amount" = 0 THEN TaxReportLine."Base Amount VAT0":=TaxReportLine."Base Amount"
            ELSE
              TaxReportLine."Base Amount VAT7":=TaxReportLine."VAT Amount";
            TaxReportLine.INSERT;
            VatTransection."Get to Tax":=true;
            VatTransection.Modify();
          end;
        end;
      until VatTransection.next = 0;
  end;
}
