SELECT 
    T0.DocEntry, isnull(N.BeginStr,'') + CAST(T0.DocNum as varchar(30))as "DocNum", T0.CardCode, T0.CardName, T18.Address, T4.FrgnName,
   
    ATT.FileContnt,
    CONVERT(VARCHAR, T0.DocDate, 103) AS [DocDate], 
    CONVERT(VARCHAR, T0.TaxDate, 103) AS [Supplier Date],
    T1.ItemCode, T1.Dscription, T1.Quantity, T0.RoundDif,s.TrnspName as "Dispatch Type",
    T1.U_PricePerKg AS [SPLL price],
    T1.U_Total AS [Spl Total],
    T1.unitMsr, T1.ShipDate, T0.UserSign, T0.SlpCode,
    T0.TrnspCode, T0.DocDueDate, T0.NumAtCard, T12.PymntGroup AS [Payment Terms],
    T1.Price, T1.LineTotal, T1.TotalFrgn, T1.Rate, T7.TaxId0, T7.State,
    STB.Name AS [StateB],	
    A.CompnyName AS [Company Name],
    A.Phone1 AS [Phone No],
    A.RevOffice AS [PAN No],
    A1.TaxIdNum5 AS [GST No],
    STS.eCode AS [StateCode],
    STC.Name AS [Company State],
    CON.Name AS [Country],
    REPLACE(A.CompnyAddr, CHAR(13), ',') AS [Company Adddress],
    SAC.ServCode AS [SacCode],
    T5.ChapterID AS [HSN],
    REPLACE(T0.Address, CHAR(13), ',') AS [BillToAddrs], 
    T17.GSTRegnNo AS [Bill to GST],
    REPLACE(T0.Address2, CHAR(13), ',') AS [ShipToAddrs],
    T18.GSTRegnNo AS [Ship to GST],
    '' AS [Cellolar], '' AS [E_MailL], '' AS [Name],
    T1.VatPrcnt,
    T19.TaxSum AS [CGST], 
    T20.TaxSum AS [SGST], 
    T21.TaxSum AS [IGST],
    T0.RoundDif, T0.DocTotal,
    T0.NumAtCard AS [So NumAtCard],
    T0.Comments AS [Header Remarks],
    T1.FreeTxt AS [Remarks], T1.Text AS [Remarks 1],
	So1.NumAtCard as "Customer Po No.",
	so1.TaxDate as "Customer PO date",
  
    T0.U_ewbValDate AS [Eway Valid Till],
    T0.U_TransId AS [Transpotor ID],
    T0.U_VehNo AS [Vehicle No]
  
FROM ODLN T0
INNER JOIN DLN1 T1 ON T0.DocEntry = T1.DocEntry
LEFT JOIN OITM T4 ON T1.ItemCode = T4.ItemCode 
LEFT JOIN OCHP T5 ON T4.ChapterID = T5.AbsEntry
LEFT JOIN OCPR T6 ON T0.CardCode = T6.CardCode
 LEFT JOIN OSHP S ON T0.[TrnspCode] = S.[TrnspCode]
LEFT JOIN DLN12 T7 ON T0.DocEntry = T7.DocEntry 
LEFT JOIN OCTG T12 ON T0.GroupNum = T12.GroupNum
LEFT JOIN ADM1 A1 ON 1=1
LEFT JOIN OADM A ON 1=1
LEFT JOIN CRD1 T17 ON T17.Address = T0.PayToCode AND T17.AdresType = 'B' AND T17.CardCode = T0.CardCode
LEFT JOIN CRD1 T18 ON T18.Address = T0.ShipToCode AND T18.AdresType = 'S' AND T18.CardCode = T0.CardCode
LEFT JOIN (
    SELECT SUM(T0.TaxSum) AS [TaxSum], T0.DocEntry  
    FROM DLN4 T0 
    LEFT JOIN OSTA O ON O.Code = T0.StaCode
    WHERE O.Name LIKE 'SGST%'
    GROUP BY T0.DocEntry 
) T20 ON T20.DocEntry = T0.DocEntry
LEFT JOIN (
    SELECT SUM(T0.TaxSum) AS [TaxSum], T0.DocEntry  
    FROM DLN4 T0 
    LEFT JOIN OSTA O ON O.Code = T0.StaCode
    WHERE O.Name LIKE 'CGST%'
    GROUP BY T0.DocEntry 
) T19 ON T19.DocEntry = T0.DocEntry
LEFT JOIN (
    SELECT SUM(T0.TaxSum) AS [TaxSum], T0.DocEntry  
    FROM DLN4 T0 
    LEFT JOIN OSTA O ON O.Code = T0.StaCode
    WHERE O.Name LIKE 'IGST%'
    GROUP BY T0.DocEntry 
) T21 ON T21.DocEntry = T0.DocEntry
LEFT JOIN OCRD T16 ON T16.CardCode = T0.CardCode
LEFT JOIN OCST STS ON STS.Code = T18.State AND STS.Country = T18.Country
LEFT JOIN OCST STB ON STB.Code = T17.State AND STB.Country = T17.Country
LEFT JOIN OCST STC ON STC.Code = A.State AND STC.Country = A.Country
LEFT JOIN OCRY CON ON CON.Code = A.Country
LEFT JOIN OSAC SAC ON T1.SacEntry = SAC.AbsEntry
LEFT JOIN OQRC ATT ON ATT.SrcObjAbs = T0.DocEntry AND ATT.SrcObjType = '13'
LEFT JOIN RDR1 SO ON SO.DocEntry = T1.BaseEntry AND SO.LineNum = T1.BaseLine
LEFT JOIN ORDR SO1 ON SO1.DocEntry = SO.DocEntry
left outer join nnm1 N on T0.Series =N.Series

WHERE T0.CANCELED = 'N'   AND T0.DocEntry = {?DocKey@}
ORDER BY T0.DocEntry, T1.LineNum