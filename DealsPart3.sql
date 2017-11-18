USE deals;
ALTER TABLE DEALTYPES  
  ADD FOREIGN KEY (TypeCode)
    REFERENCES TypeCodes (TypeCode);
ALTER TABLE DEALTYPES 
  ADD FOREIGN KEY (DealID)
    REFERENCES DEALS (DealID);
ALTER TABLE DealParts  
  ADD FOREIGN KEY (DealID)
    REFERENCES Deals (DealID);
ALTER TABLE Players  
  ADD FOREIGN KEY (DealID)
    REFERENCES Deals (DealID);
ALTER TABLE Players 
  ADD FOREIGN KEY (CompanyID)
    REFERENCES Companies (CompanyID);
ALTER TABLE Players  
  ADD FOREIGN KEY (RoleCode)
    REFERENCES RoleCodes (RoleCode);
ALTER TABLE PlayerSupports  
  ADD FOREIGN KEY (PlayerID)
    REFERENCES Players (PlayerID);
ALTER TABLE PlayerSupports  
  ADD FOREIGN KEY (SupportCodeID)
    REFERENCES SupportCodes (SupportCodeID);
ALTER TABLE PlayerSupports  
  ADD FOREIGN KEY (FirmID)
    REFERENCES Firms (FirmID);