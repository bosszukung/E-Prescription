// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title EPrescription
 * @dev A decentralized prescription management system on Ethereum blockchain
 * @author Aekkaraj K.
 * 
 * Features:
 * - Role-based access control (Doctors, Patients, Pharmacists)
 * - Immutable prescription records
 * - Expiration validation
 * - Cryptographic verification
 */

contract EPrescription {
    
    // ============ STATE VARIABLES ============
    address public owner;
    uint256 public prescriptionId;
    
    // ============ STRUCTURES ============
    
    /**
     * @dev Prescription data structure
     */
    struct PrescriptionForm {
        address GP;                 // Doctor who issued prescription
        address Patient;            // Patient receiving prescription  
        string PIPcode;            // 7-digit unique medication traceability code
        string medicationName;     // Scientific name of medication
        uint256 dosage;            // Quantity per dose
        string dosageUnit;         // Unit (mg, ml, tablets, etc.)
        uint8 numPills;            // Total number of doses
        uint8 repeat;              // Frequency per day
        string specificTime;       // Timing (morning, afternoon, evening)
        string BeforeOrAfter;      // Relative to meals (before/after)
        uint256 date;              // Issue timestamp (Unix)
        uint256 expirationTime;    // Expiry timestamp (Unix)
        bool isActive;             // Active status
    }
    
    // ============ MAPPINGS ============
    
    /// @dev Maps prescription ID to prescription data
    mapping(uint256 => PrescriptionForm) public prescriptions;
    
    /// @dev Maps doctor addresses to approval status
    mapping(address => bool) public approvedDoctors;
    
    /// @dev Maps pharmacist addresses to permission status
    mapping(address => bool) public approvedPharmacists;
    
    /// @dev Maps patient to their prescription IDs
    mapping(address => uint256[]) public patientPrescriptions;
    
    // ============ EVENTS ============
    
    event DoctorApproved(address indexed doctor, bool approved);
    event PharmacistApproved(address indexed pharmacist, bool approved);
    event PrescriptionAdded(
        uint256 indexed prescriptionId,
        address indexed GP,
        address indexed Patient,
        string PIPcode,
        string medicationName,
        uint256 dosage,
        string dosageUnit,
        uint8 numPills,
        uint8 repeat,
        string specificTime,
        string BeforeOrAfter,
        uint256 date,
        uint256 expirationTime
    );
    event PrescriptionCanceled(uint256 indexed prescriptionId);
    event MedicationDispensed(uint256 indexed prescriptionId, address indexed pharmacist);
    
    // ============ MODIFIERS ============
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }
    
    modifier onlyApprovedDoctor() {
        require(approvedDoctors[msg.sender], "Doctor not approved to issue prescriptions");
        _;
    }
    
    modifier onlyApprovedPharmacist() {
        require(approvedPharmacists[msg.sender], "Pharmacist not approved");
        _;
    }
    
    modifier prescriptionExists(uint256 _prescriptionId) {
        require(prescriptions[_prescriptionId].Patient != address(0), "Prescription does not exist");
        _;
    }
    
    modifier prescriptionNotExpired(uint256 _prescriptionId) {
        require(block.timestamp <= prescriptions[_prescriptionId].expirationTime, "Prescription has expired");
        _;
    }
    
    modifier onlyPatient(uint256 _prescriptionId) {
        require(prescriptions[_prescriptionId].Patient == msg.sender, "Only prescribed patient can access");
        _;
    }
    
    // ============ CONSTRUCTOR ============
    
    /**
     * @dev Initialize contract with owner
     */
    constructor() {
        owner = msg.sender;
        prescriptionId = 0;
    }
    
    // ============ DOCTOR FUNCTIONS ============
    
    /**
     * @dev Approve a doctor to issue prescriptions
     * @param _doctorAddress Address of doctor to approve
     */
    function approveDcotor(address _doctorAddress) external onlyOwner {
        require(_doctorAddress != address(0), "Invalid doctor address");
        approvedDoctors[_doctorAddress] = true;
        emit DoctorApproved(_doctorAddress, true);
    }
    
    /**
     * @dev Remove doctor approval
     * @param _doctorAddress Address of doctor to remove
     */
    function removeDoctorApproval(address _doctorAddress) external onlyOwner {
        require(_doctorAddress != address(0), "Invalid doctor address");
        approvedDoctors[_doctorAddress] = false;
        emit DoctorApproved(_doctorAddress, false);
    }
    
    /**
     * @dev Issue a new prescription
     * @param _Patient Address of patient
     * @param _PIPcode Unique medication traceability code
     * @param _medicationName Name of medication
     * @param _dosage Dosage amount
     * @param _dosageUnit Unit of dosage
     * @param _numPills Number of doses
     * @param _repeat Frequency per day
     * @param _specificTime Time to take medication
     * @param _BeforeOrAfter Before or after meals
     * @param _date Issue date timestamp
     * @param _expirationTime Expiry date timestamp
     */
    function issuePrescription(
        address _Patient,
        string memory _PIPcode,
        string memory _medicationName,
        uint256 _dosage,
        string memory _dosageUnit,
        uint8 _numPills,
        uint8 _repeat,
        string memory _specificTime,
        string memory _BeforeOrAfter,
        uint256 _date,
        uint256 _expirationTime
    ) external onlyApprovedDoctor {
        require(_Patient != address(0), "Invalid patient address");
        require(_expirationTime > _date, "Expiration time must be after issue date");
        require(bytes(_medicationName).length > 0, "Medication name cannot be empty");
        
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
            _specificTime,
            _BeforeOrAfter,
            _date,
            _expirationTime,
            true
        );
        
        patientPrescriptions[_Patient].push(prescriptionId);
        
        emit PrescriptionAdded(
            prescriptionId,
            msg.sender,
            _Patient,
            _PIPcode,
            _medicationName,
            _dosage,
            _dosageUnit,
            _numPills,
            _repeat,
            _specificTime,
            _BeforeOrAfter,
            _date,
            _expirationTime
        );
    }
    
    /**
     * @dev Cancel a prescription
     * @param _prescriptionId ID of prescription to cancel
     */
    function cancelPrescription(uint256 _prescriptionId) 
        external 
        prescriptionExists(_prescriptionId) 
    {
        PrescriptionForm storage p = prescriptions[_prescriptionId];
        require(p.GP == msg.sender, "Only issuing doctor can cancel");
        require(p.isActive, "Prescription already canceled");
        
        p.isActive = false;
        emit PrescriptionCanceled(_prescriptionId);
    }
    
    // ============ PHARMACIST FUNCTIONS ============
    
    /**
     * @dev Approve a pharmacist
     * @param _pharmacistAddress Address of pharmacist
     */
    function approvePharmacist(address _pharmacistAddress) external onlyOwner {
        require(_pharmacistAddress != address(0), "Invalid pharmacist address");
        approvedPharmacists[_pharmacistAddress] = true;
        emit PharmacistApproved(_pharmacistAddress, true);
    }
    
    /**
     * @dev Remove pharmacist approval
     * @param _pharmacistAddress Address of pharmacist
     */
    function removePharmacistApproval(address _pharmacistAddress) external onlyOwner {
        require(_pharmacistAddress != address(0), "Invalid pharmacist address");
        approvedPharmacists[_pharmacistAddress] = false;
        emit PharmacistApproved(_pharmacistAddress, false);
    }
    
    /**
     * @dev Dispense medication (record dispensation)
     * @param _prescriptionId ID of prescription
     */
    function dispenseMedication(uint256 _prescriptionId) 
        external 
        onlyApprovedPharmacist 
        prescriptionExists(_prescriptionId)
        prescriptionNotExpired(_prescriptionId)
    {
        require(prescriptions[_prescriptionId].isActive, "Prescription is not active");
        emit MedicationDispensed(_prescriptionId, msg.sender);
    }
    
    // ============ PATIENT FUNCTIONS ============
    
    /**
     * @dev Get all prescriptions for patient
     */
    function getMyPrescriptions() external view returns (uint256[] memory) {
        return patientPrescriptions[msg.sender];
    }
    
    /**
     * @dev View a specific prescription
     * @param _prescriptionId ID of prescription
     */
    function viewPrescription(uint256 _prescriptionId) 
        external 
        view 
        prescriptionExists(_prescriptionId)
        onlyPatient(_prescriptionId)
        returns (PrescriptionForm memory)
    {
        return prescriptions[_prescriptionId];
    }
    
    // ============ UTILITY FUNCTIONS ============
    
    /**
     * @dev Check if prescription is valid
     * @param _prescriptionId ID of prescription
     */
    function isPrescriptionValid(uint256 _prescriptionId) 
        external 
        view 
        returns (bool)
    {
        if (!prescriptionExists(_prescriptionId)) return false;
        PrescriptionForm storage p = prescriptions[_prescriptionId];
        return p.isActive && block.timestamp <= p.expirationTime;
    }
    
    /**
     * @dev Get prescription details (public read)
     * @param _prescriptionId ID of prescription
     */
    function getPrescription(uint256 _prescriptionId) 
        external 
        view 
        prescriptionExists(_prescriptionId)
        returns (PrescriptionForm memory)
    {
        return prescriptions[_prescriptionId];
    }
    
    /**
     * @dev Check if doctor is approved
     * @param _doctorAddress Address to check
     */
    function isDoctorApproved(address _doctorAddress) external view returns (bool) {
        return approvedDoctors[_doctorAddress];
    }
    
    /**
     * @dev Check if pharmacist is approved
     * @param _pharmacistAddress Address to check
     */
    function isPharmacistApproved(address _pharmacistAddress) external view returns (bool) {
        return approvedPharmacists[_pharmacistAddress];
    }
}
