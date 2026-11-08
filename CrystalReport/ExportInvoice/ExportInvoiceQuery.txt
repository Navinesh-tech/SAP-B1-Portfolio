select T0.CardCode,T0.CardName,isnull(T2.BeginStr,'') + CAST(T0.DocNum as varchar(30)) as 'DocNum',
T0.DocDate,T0.NumAtCard as 'PO Number',Po.TaxDate as 'PO Date',
T0.Address  as 'BillToAddress',T5.GSTRegnNo as 'BillToGST',case when T6.Code='KT' then 'Karnataka' else T6.[Name] end as 'BillToState',T6.GSTCode as 'BillToGSTCode',
T0.Address2 as 'ShipToAddress',T7.GSTRegnNo as 'ShipToGST',case when T8.Code='KT' then 'Karnataka' else T8.[Name] end as 'ShipToState',T8.GSTCode as 'ShipToGSTCode',
T9.ItemCode,T1.Dscription as 'ItemName',T9.U_DrawingNo 'Customer Drawing No',T1.Quantity, T1.Price as 'Unit Price',T12.[PymntGroup],
case when T0.DocCur='INR' then
T1.LineTotal else T1.TotalFrgn end as 'RowTotal', 
case when T0.DocCur='INR' then
T0.DocTotal else T0.DocTotalFC end as 'DocTotal', 
case when T0.DocCur='INR' then
T0.RoundDif else T0.RoundDifFC end as 'Rounding', 
case when T0.DocCur='INR' then
T0.DiscSum else T0.DiscSumFC end as 'DisCount', 
case when T0.DocCur='INR' then
T0.TotalExpns else T0.TotalExpFC end as 'Freight_Charges' ,
case when T0.DocCur='INR' then
T0.VatSum else T0.VatSumFC end  as 'TaxAmount' ,
case when T0.DocCur='INR' then
T0.WTSum else T0.WTSumFC end  as 'WithHoldingTax' ,
isnull(IG.Rate,0) as 'IGST Rate',
isnull(IG.TaxSum,0) as 'IGST Row Amount',
isnull(CG.Rate,0) as 'CGST Rate',
isnull(CG.TaxSum,0) as 'CGST Row Amount',
isnull(SG.Rate,0) as 'SGST Rate',
isnull(SG.TaxSum,0) as 'SGST Row Amount',isnull(T11.BeginStr,'') + CAST(T1.BaseDocNum as varchar(30)) as 'DCNumber', T10.DocDate as 'DC Date',Replace(H.ChapterID,'.','') ChapterID

from 

OINV T0
INNER JOIN INV1 T1 on T0.DocEntry=T1.DocEntry
INNER JOIN NNM1 T2 on T2.series =T0.Series and T2.ObjectCode=T0.ObjType
left JOin OCHP H on H.AbsEntry=T1.HsnEntry
LEFT JOIN (SELECT R.NumAtCard, MAX(R.TaxDate) as TaxDate FROM ORDR R where R.CANCELED='N' Group by R.NumAtCard) PO on PO.NumAtCard=t0.NumAtCard -- GET CUSTOMER PO DATE 
--LEFT JOIN INV12 T3 on T3.DocEntry=T0.DocEntry
--LEFT JOIN OCST T4 on T4.Code=T3.StateB
LEFT JOIN CRD1 T5 on T5.CardCode=T0.CardCode and T5.AdresType='B' and T5.Address=T0.PayToCode -- -- Billing Address
LEFT JOIN OCST T6 on T6.Code=T5.State -- Bill to State
LEFT JOIN CRD1 T7 on T7.CardCode=T0.CardCode and T7.AdresType='S' and T7.Address=T0.ShipToCode -- -- Shipping Address
LEFT JOIN OCST T8 on T8.Code=T7.State -- Shipping to State
LEFT JOIN OITM T9 on T9.ItemCode=T1.ItemCode
 LEFT JOIN OCTG T12 ON T0.[GroupNum] = T12.[GroupNum]

LEFT JOIN (
SELECT O."Name" "StaCode",SUM(T0."TaxSum") as "TaxSum",O.Rate,T0.DocEntry,T0.LineNum  FROM INV4 T0 
LEFT JOIN OSTA O on O."Code" =T0."StaCode"
group by O."Name",O.Rate,T0.DocEntry,T0.LineNum) IG on IG.DocEntry=T0.DocEntry  and IG.LineNum=T1.LineNum  and IG."StaCode" like '%IGST%'

LEFT JOIN (
SELECT O."Name" "StaCode",SUM(T0."TaxSum") as "TaxSum",O.Rate,T0.DocEntry,T0.LineNum  FROM INV4 T0 
LEFT JOIN OSTA O on O."Code" =T0."StaCode"
group by O."Name",O.Rate,T0.DocEntry,T0.LineNum) CG on CG.DocEntry=T0.DocEntry  and CG.LineNum=T1.LineNum  and CG."StaCode" like '%CGST%'

LEFT JOIN (
SELECT O."Name" "StaCode",SUM(T0."TaxSum") as "TaxSum",O.Rate,T0.DocEntry,T0.LineNum  FROM INV4 T0 
LEFT JOIN OSTA O on O."Code" =T0."StaCode"
group by O."Name",O.Rate,T0.DocEntry,T0.LineNum) SG on SG.DocEntry=T0.DocEntry   and SG.LineNum=T1.LineNum  and SG."StaCode" like '%SGST%'


LEFT JOIN ODLN T10 on T10.DocNum=T1.BaseDocNum
INNER JOIN NNM1 T11 on T11.series =T10.Series and T11.ObjectCode=T10.ObjType
LEFT JOIN OADM C on 1=1

where  T0.DocEntry={?DocKey@};