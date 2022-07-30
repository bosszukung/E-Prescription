pragma solidity >=0.8.0;
pragma experimental ABIEncoderV2;
// SPDX-License-Identifier: MIT

import "https://github.com/bosszukung/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "./SafeMath.sol";

contract EPrescription {
    
    address owner;
    uint256 public prescriptionId;

    struct PrescriptionForm {
        address GP; //Address of doctor that issued this prescription
        address Patient;    //Address of Patient that receives this prescription
        string PIPcode; //A unique seven-digit coding system used to ensure traceability of medication
        string medicationName;  //Scientific name of the medicine
        uint256 dosage;   //qutity per pill
        string dosageUnit;  //Unit of the dosage ex. mg, ml and etc
        uint8 numPills; //qulity of pills to give in the prescription
        uint8 repeat; // qutity of time to take the pill (ex.  2 means two times a day)
        string spicificTime; // time to take the pill (ex. in the morning, afternon, evening)
        string BeforeOrAfter; // take the pill before or after meal
        uint256 date; //Epoch time when the prescription was given
        uint256 expirationTime; //Epoch expiration date (When is this prescription no longer valid)
    }


    mapping(uint256 => PrescriptionForm) public prescriptions; //Mapping to Prescription struct
    mapping(address => bool) public GP; //Mapping the doctor address
    mapping (address => bool) public chemists; //Mapping the chenmist address

      constructor() {
        owner = msg.sender;
    }

    function approved(address _GPToApprove) public onlyOwner {
        GP[_GPToApprove] = false;  
    }   //_GPToApprove uint256 ID of doctor to approve for giving prescriptions
    
    function permissionPhamacy (address _phamacist) public view returns (bool) {
        return chemists[_phamacist]; 
    }   //given permission to chemist 

    event PrescriptionAdded(
        address Patient,    //Address of Patient that receives this prescription
        string PIPcode, //A unique seven-digit coding system used to ensure traceability of medication
        string medicationName,  //Scientific name of the medicine
        uint256 dosage,   //qutity per pill
        string dosageUnit,  //Unit of the dosage ex. mg, ml and etc
        uint8 numPills, //qulity of pills to give in the prescription
        uint8 repeat, // qutity of time to take the pill (ex.  2 means two times a day)
        string spicificTime, // time to take the pill (ex. in the morning, afternon, evening)
        string BeforeOrAfter, // take the pill before or after meal
        uint256 date, //Epoch time when the prescription was given
        uint256 expirationTime //Epoch expiration date (When is this prescription no longer valid)
    );

    function AddPrescrition(
        address _Patient, 
        string memory _PIPcode, 
        string memory _medicationName, 
        uint8 _dosage, 
        string memory _dosageUnit, 
        uint8 _numPills, 
        uint8 _repeat, 
        string memory _spicificTime, 
        string memory _BeforeOrAfter, 
        uint256 _date, 
        uint256 _expirationTime) public payable {
            prescriptionId++;
            prescriptions[prescriptionId] = PrescriptionForm(
                msg.sender,
                _Patient,
                _PIPcode,
                _medicationName,
                _dosage,
                _dosageUnit,
                _numPills,
                _repeat,
                _spicificTime,
                _BeforeOrAfter,
                _date,
                _expirationTime
                
            ); 
            emit PrescriptionAdded(
                msg.sender, 
                _Patient,
                _PIPcode,
                _medicationName,
                _dosage,
                _dosageUnit,
                _numPills,
                _repeat,
                _spicificTime,
                _BeforeOrAfter,
                _date,
                _expirationTime
            );
            
    }

    function cancelPrescription(uint256 _prescriptionId) public payable GPIsApproved(msg.sender){
        PrescriptionForm memory p = prescriptions[_prescriptionId];
        require(p.GP == msg.sender);
    }    

    function giveMedication(address _phamacist) public view {
        require (permissionPhamacy(_phamacist) == true);
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
  }

    modifier GPIsApproved(address _GP) {
        require(GP[_GP]);
        _;  //Guarantees that address belongs to a valid and approved doctor
  }
    modifier hasNotExpired(uint256 _prescriptionId) {
        uint256 timeToExpiry = prescriptions[prescriptionId].expirationTime - block.timestamp;
        require(timeToExpiry > 0);
         _; //Guarantees prescription is not being used after its expiration date
    }
    
    modifier onlyPrescribedPatient(uint256 _prescriptionId) {
        require(prescriptions[prescriptionId].Patient == msg.sender);
        _;  //Guarantees msg.sender is patient who was actually prescribed
    }
   
}