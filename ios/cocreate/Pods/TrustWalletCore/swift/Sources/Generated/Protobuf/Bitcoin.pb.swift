// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: Bitcoin.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public struct TW_Bitcoin_Proto_Transaction {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Transaction data format version.
  public var version: Int32 = 0

  /// The block number or timestamp at which this transaction is unlocked.
  public var lockTime: UInt32 = 0

  /// A list of 1 or more transaction inputs or sources for coins.
  public var inputs: [TW_Bitcoin_Proto_TransactionInput] = []

  /// A list of 1 or more transaction outputs or destinations for coins
  public var outputs: [TW_Bitcoin_Proto_TransactionOutput] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Bitcoin transaction input.
public struct TW_Bitcoin_Proto_TransactionInput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Reference to the previous transaction's output.
  public var previousOutput: TW_Bitcoin_Proto_OutPoint {
    get {return _previousOutput ?? TW_Bitcoin_Proto_OutPoint()}
    set {_previousOutput = newValue}
  }
  /// Returns true if `previousOutput` has been explicitly set.
  public var hasPreviousOutput: Bool {return self._previousOutput != nil}
  /// Clears the value of `previousOutput`. Subsequent reads from it will return its default value.
  public mutating func clearPreviousOutput() {self._previousOutput = nil}

  /// Transaction version as defined by the sender.
  public var sequence: UInt32 = 0

  /// Computational script for confirming transaction authorization.
  public var script: Data = SwiftProtobuf.Internal.emptyData

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _previousOutput: TW_Bitcoin_Proto_OutPoint? = nil
}

/// Bitcoin transaction out-point reference.
public struct TW_Bitcoin_Proto_OutPoint {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The hash of the referenced transaction.
  public var hash: Data = SwiftProtobuf.Internal.emptyData

  /// The index of the specific output in the transaction.
  public var index: UInt32 = 0

  /// Transaction version as defined by the sender.
  public var sequence: UInt32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Bitcoin transaction output.
public struct TW_Bitcoin_Proto_TransactionOutput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Transaction amount.
  public var value: Int64 = 0

  /// Usually contains the public key as a Bitcoin script setting up conditions to claim this output.
  public var script: Data = SwiftProtobuf.Internal.emptyData

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct TW_Bitcoin_Proto_UnspentTransaction {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var outPoint: TW_Bitcoin_Proto_OutPoint {
    get {return _outPoint ?? TW_Bitcoin_Proto_OutPoint()}
    set {_outPoint = newValue}
  }
  /// Returns true if `outPoint` has been explicitly set.
  public var hasOutPoint: Bool {return self._outPoint != nil}
  /// Clears the value of `outPoint`. Subsequent reads from it will return its default value.
  public mutating func clearOutPoint() {self._outPoint = nil}

  public var script: Data = SwiftProtobuf.Internal.emptyData

  public var amount: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _outPoint: TW_Bitcoin_Proto_OutPoint? = nil
}

/// Input data necessary to create a signed transaction.
public struct TW_Bitcoin_Proto_SigningInput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Hash type to use when signing.
  public var hashType: UInt32 = 0

  /// Amount to send.
  public var amount: Int64 = 0

  /// Transaction fee per byte.
  public var byteFee: Int64 = 0

  /// Recipient's address.
  public var toAddress: String = String()

  /// Change address.
  public var changeAddress: String = String()

  /// Available private keys.
  public var privateKey: [Data] = []

  /// Available redeem scripts indexed by script hash.
  public var scripts: Dictionary<String,Data> = [:]

  /// Available unspent transaction outputs.
  public var utxo: [TW_Bitcoin_Proto_UnspentTransaction] = []

  /// If sending max amount.
  public var useMaxAmount: Bool = false

  /// Coin type (forks).
  public var coinType: UInt32 = 0

  /// Optional transaction plan
  public var plan: TW_Bitcoin_Proto_TransactionPlan {
    get {return _plan ?? TW_Bitcoin_Proto_TransactionPlan()}
    set {_plan = newValue}
  }
  /// Returns true if `plan` has been explicitly set.
  public var hasPlan: Bool {return self._plan != nil}
  /// Clears the value of `plan`. Subsequent reads from it will return its default value.
  public mutating func clearPlan() {self._plan = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _plan: TW_Bitcoin_Proto_TransactionPlan? = nil
}

/// Describes a preliminary transaction plan.
public struct TW_Bitcoin_Proto_TransactionPlan {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Amount to be received at the other end.
  public var amount: Int64 = 0

  /// Maximum available amount.
  public var availableAmount: Int64 = 0

  /// Estimated transaction fee.
  public var fee: Int64 = 0

  /// Change.
  public var change: Int64 = 0

  /// Selected unspent transaction outputs.
  public var utxos: [TW_Bitcoin_Proto_UnspentTransaction] = []

  /// Zcash branch id
  public var branchID: Data = SwiftProtobuf.Internal.emptyData

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Transaction signing output.
public struct TW_Bitcoin_Proto_SigningOutput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Resulting transaction. Note that the amount may be different than the requested amount to account for fees and available funds.
  public var transaction: TW_Bitcoin_Proto_Transaction {
    get {return _transaction ?? TW_Bitcoin_Proto_Transaction()}
    set {_transaction = newValue}
  }
  /// Returns true if `transaction` has been explicitly set.
  public var hasTransaction: Bool {return self._transaction != nil}
  /// Clears the value of `transaction`. Subsequent reads from it will return its default value.
  public mutating func clearTransaction() {self._transaction = nil}

  /// Signed and encoded transaction bytes.
  public var encoded: Data = SwiftProtobuf.Internal.emptyData

  /// Transaction id
  public var transactionID: String = String()

  /// Optional error message
  public var error: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _transaction: TW_Bitcoin_Proto_Transaction? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "TW.Bitcoin.Proto"

extension TW_Bitcoin_Proto_Transaction: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Transaction"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "version"),
    2: .same(proto: "lockTime"),
    3: .same(proto: "inputs"),
    4: .same(proto: "outputs"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularSInt32Field(value: &self.version)
      case 2: try decoder.decodeSingularUInt32Field(value: &self.lockTime)
      case 3: try decoder.decodeRepeatedMessageField(value: &self.inputs)
      case 4: try decoder.decodeRepeatedMessageField(value: &self.outputs)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.version != 0 {
      try visitor.visitSingularSInt32Field(value: self.version, fieldNumber: 1)
    }
    if self.lockTime != 0 {
      try visitor.visitSingularUInt32Field(value: self.lockTime, fieldNumber: 2)
    }
    if !self.inputs.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.inputs, fieldNumber: 3)
    }
    if !self.outputs.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.outputs, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Bitcoin_Proto_Transaction, rhs: TW_Bitcoin_Proto_Transaction) -> Bool {
    if lhs.version != rhs.version {return false}
    if lhs.lockTime != rhs.lockTime {return false}
    if lhs.inputs != rhs.inputs {return false}
    if lhs.outputs != rhs.outputs {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Bitcoin_Proto_TransactionInput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TransactionInput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "previousOutput"),
    2: .same(proto: "sequence"),
    3: .same(proto: "script"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._previousOutput)
      case 2: try decoder.decodeSingularUInt32Field(value: &self.sequence)
      case 3: try decoder.decodeSingularBytesField(value: &self.script)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._previousOutput {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if self.sequence != 0 {
      try visitor.visitSingularUInt32Field(value: self.sequence, fieldNumber: 2)
    }
    if !self.script.isEmpty {
      try visitor.visitSingularBytesField(value: self.script, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Bitcoin_Proto_TransactionInput, rhs: TW_Bitcoin_Proto_TransactionInput) -> Bool {
    if lhs._previousOutput != rhs._previousOutput {return false}
    if lhs.sequence != rhs.sequence {return false}
    if lhs.script != rhs.script {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Bitcoin_Proto_OutPoint: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".OutPoint"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "hash"),
    2: .same(proto: "index"),
    3: .same(proto: "sequence"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.hash)
      case 2: try decoder.decodeSingularUInt32Field(value: &self.index)
      case 3: try decoder.decodeSingularUInt32Field(value: &self.sequence)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.hash.isEmpty {
      try visitor.visitSingularBytesField(value: self.hash, fieldNumber: 1)
    }
    if self.index != 0 {
      try visitor.visitSingularUInt32Field(value: self.index, fieldNumber: 2)
    }
    if self.sequence != 0 {
      try visitor.visitSingularUInt32Field(value: self.sequence, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Bitcoin_Proto_OutPoint, rhs: TW_Bitcoin_Proto_OutPoint) -> Bool {
    if lhs.hash != rhs.hash {return false}
    if lhs.index != rhs.index {return false}
    if lhs.sequence != rhs.sequence {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Bitcoin_Proto_TransactionOutput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TransactionOutput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
    2: .same(proto: "script"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt64Field(value: &self.value)
      case 2: try decoder.decodeSingularBytesField(value: &self.script)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.value != 0 {
      try visitor.visitSingularInt64Field(value: self.value, fieldNumber: 1)
    }
    if !self.script.isEmpty {
      try visitor.visitSingularBytesField(value: self.script, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Bitcoin_Proto_TransactionOutput, rhs: TW_Bitcoin_Proto_TransactionOutput) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.script != rhs.script {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Bitcoin_Proto_UnspentTransaction: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".UnspentTransaction"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "out_point"),
    2: .same(proto: "script"),
    3: .same(proto: "amount"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._outPoint)
      case 2: try decoder.decodeSingularBytesField(value: &self.script)
      case 3: try decoder.decodeSingularInt64Field(value: &self.amount)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._outPoint {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.script.isEmpty {
      try visitor.visitSingularBytesField(value: self.script, fieldNumber: 2)
    }
    if self.amount != 0 {
      try visitor.visitSingularInt64Field(value: self.amount, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Bitcoin_Proto_UnspentTransaction, rhs: TW_Bitcoin_Proto_UnspentTransaction) -> Bool {
    if lhs._outPoint != rhs._outPoint {return false}
    if lhs.script != rhs.script {return false}
    if lhs.amount != rhs.amount {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Bitcoin_Proto_SigningInput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".SigningInput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "hash_type"),
    2: .same(proto: "amount"),
    3: .standard(proto: "byte_fee"),
    4: .standard(proto: "to_address"),
    5: .standard(proto: "change_address"),
    10: .standard(proto: "private_key"),
    11: .same(proto: "scripts"),
    12: .same(proto: "utxo"),
    13: .standard(proto: "use_max_amount"),
    14: .standard(proto: "coin_type"),
    15: .same(proto: "plan"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularUInt32Field(value: &self.hashType)
      case 2: try decoder.decodeSingularInt64Field(value: &self.amount)
      case 3: try decoder.decodeSingularInt64Field(value: &self.byteFee)
      case 4: try decoder.decodeSingularStringField(value: &self.toAddress)
      case 5: try decoder.decodeSingularStringField(value: &self.changeAddress)
      case 10: try decoder.decodeRepeatedBytesField(value: &self.privateKey)
      case 11: try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufString,SwiftProtobuf.ProtobufBytes>.self, value: &self.scripts)
      case 12: try decoder.decodeRepeatedMessageField(value: &self.utxo)
      case 13: try decoder.decodeSingularBoolField(value: &self.useMaxAmount)
      case 14: try decoder.decodeSingularUInt32Field(value: &self.coinType)
      case 15: try decoder.decodeSingularMessageField(value: &self._plan)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.hashType != 0 {
      try visitor.visitSingularUInt32Field(value: self.hashType, fieldNumber: 1)
    }
    if self.amount != 0 {
      try visitor.visitSingularInt64Field(value: self.amount, fieldNumber: 2)
    }
    if self.byteFee != 0 {
      try visitor.visitSingularInt64Field(value: self.byteFee, fieldNumber: 3)
    }
    if !self.toAddress.isEmpty {
      try visitor.visitSingularStringField(value: self.toAddress, fieldNumber: 4)
    }
    if !self.changeAddress.isEmpty {
      try visitor.visitSingularStringField(value: self.changeAddress, fieldNumber: 5)
    }
    if !self.privateKey.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.privateKey, fieldNumber: 10)
    }
    if !self.scripts.isEmpty {
      try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufString,SwiftProtobuf.ProtobufBytes>.self, value: self.scripts, fieldNumber: 11)
    }
    if !self.utxo.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.utxo, fieldNumber: 12)
    }
    if self.useMaxAmount != false {
      try visitor.visitSingularBoolField(value: self.useMaxAmount, fieldNumber: 13)
    }
    if self.coinType != 0 {
      try visitor.visitSingularUInt32Field(value: self.coinType, fieldNumber: 14)
    }
    if let v = self._plan {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 15)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Bitcoin_Proto_SigningInput, rhs: TW_Bitcoin_Proto_SigningInput) -> Bool {
    if lhs.hashType != rhs.hashType {return false}
    if lhs.amount != rhs.amount {return false}
    if lhs.byteFee != rhs.byteFee {return false}
    if lhs.toAddress != rhs.toAddress {return false}
    if lhs.changeAddress != rhs.changeAddress {return false}
    if lhs.privateKey != rhs.privateKey {return false}
    if lhs.scripts != rhs.scripts {return false}
    if lhs.utxo != rhs.utxo {return false}
    if lhs.useMaxAmount != rhs.useMaxAmount {return false}
    if lhs.coinType != rhs.coinType {return false}
    if lhs._plan != rhs._plan {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Bitcoin_Proto_TransactionPlan: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TransactionPlan"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "amount"),
    2: .standard(proto: "available_amount"),
    3: .same(proto: "fee"),
    4: .same(proto: "change"),
    5: .same(proto: "utxos"),
    6: .standard(proto: "branch_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt64Field(value: &self.amount)
      case 2: try decoder.decodeSingularInt64Field(value: &self.availableAmount)
      case 3: try decoder.decodeSingularInt64Field(value: &self.fee)
      case 4: try decoder.decodeSingularInt64Field(value: &self.change)
      case 5: try decoder.decodeRepeatedMessageField(value: &self.utxos)
      case 6: try decoder.decodeSingularBytesField(value: &self.branchID)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.amount != 0 {
      try visitor.visitSingularInt64Field(value: self.amount, fieldNumber: 1)
    }
    if self.availableAmount != 0 {
      try visitor.visitSingularInt64Field(value: self.availableAmount, fieldNumber: 2)
    }
    if self.fee != 0 {
      try visitor.visitSingularInt64Field(value: self.fee, fieldNumber: 3)
    }
    if self.change != 0 {
      try visitor.visitSingularInt64Field(value: self.change, fieldNumber: 4)
    }
    if !self.utxos.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.utxos, fieldNumber: 5)
    }
    if !self.branchID.isEmpty {
      try visitor.visitSingularBytesField(value: self.branchID, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Bitcoin_Proto_TransactionPlan, rhs: TW_Bitcoin_Proto_TransactionPlan) -> Bool {
    if lhs.amount != rhs.amount {return false}
    if lhs.availableAmount != rhs.availableAmount {return false}
    if lhs.fee != rhs.fee {return false}
    if lhs.change != rhs.change {return false}
    if lhs.utxos != rhs.utxos {return false}
    if lhs.branchID != rhs.branchID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Bitcoin_Proto_SigningOutput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".SigningOutput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "transaction"),
    2: .same(proto: "encoded"),
    3: .standard(proto: "transaction_id"),
    4: .same(proto: "error"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._transaction)
      case 2: try decoder.decodeSingularBytesField(value: &self.encoded)
      case 3: try decoder.decodeSingularStringField(value: &self.transactionID)
      case 4: try decoder.decodeSingularStringField(value: &self.error)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._transaction {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.encoded.isEmpty {
      try visitor.visitSingularBytesField(value: self.encoded, fieldNumber: 2)
    }
    if !self.transactionID.isEmpty {
      try visitor.visitSingularStringField(value: self.transactionID, fieldNumber: 3)
    }
    if !self.error.isEmpty {
      try visitor.visitSingularStringField(value: self.error, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Bitcoin_Proto_SigningOutput, rhs: TW_Bitcoin_Proto_SigningOutput) -> Bool {
    if lhs._transaction != rhs._transaction {return false}
    if lhs.encoded != rhs.encoded {return false}
    if lhs.transactionID != rhs.transactionID {return false}
    if lhs.error != rhs.error {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
