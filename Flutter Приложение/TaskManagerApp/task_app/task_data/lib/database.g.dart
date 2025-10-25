// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'firstName',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'lastName',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loginOrEmailMeta = const VerificationMeta(
    'loginOrEmail',
  );
  @override
  late final GeneratedColumn<String> loginOrEmail = GeneratedColumn<String>(
    'loginOrEmail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [firstName, lastName, loginOrEmail];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('firstName')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['firstName']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('lastName')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['lastName']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('loginOrEmail')) {
      context.handle(
        _loginOrEmailMeta,
        loginOrEmail.isAcceptableOrUnknown(
          data['loginOrEmail']!,
          _loginOrEmailMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_loginOrEmailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}firstName'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lastName'],
      )!,
      loginOrEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}loginOrEmail'],
      )!,
    );
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final String firstName;
  final String lastName;
  final String loginOrEmail;
  const UserData({
    required this.firstName,
    required this.lastName,
    required this.loginOrEmail,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['firstName'] = Variable<String>(firstName);
    map['lastName'] = Variable<String>(lastName);
    map['loginOrEmail'] = Variable<String>(loginOrEmail);
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      firstName: Value(firstName),
      lastName: Value(lastName),
      loginOrEmail: Value(loginOrEmail),
    );
  }

  factory UserData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      loginOrEmail: serializer.fromJson<String>(json['loginOrEmail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'loginOrEmail': serializer.toJson<String>(loginOrEmail),
    };
  }

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? loginOrEmail,
  }) => UserData(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    loginOrEmail: loginOrEmail ?? this.loginOrEmail,
  );
  UserData copyWithCompanion(UserCompanion data) {
    return UserData(
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      loginOrEmail: data.loginOrEmail.present
          ? data.loginOrEmail.value
          : this.loginOrEmail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('loginOrEmail: $loginOrEmail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(firstName, lastName, loginOrEmail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.loginOrEmail == this.loginOrEmail);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> loginOrEmail;
  final Value<int> rowid;
  const UserCompanion({
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.loginOrEmail = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserCompanion.insert({
    required String firstName,
    required String lastName,
    required String loginOrEmail,
    this.rowid = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       loginOrEmail = Value(loginOrEmail);
  static Insertable<UserData> custom({
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? loginOrEmail,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (loginOrEmail != null) 'loginOrEmail': loginOrEmail,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserCompanion copyWith({
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? loginOrEmail,
    Value<int>? rowid,
  }) {
    return UserCompanion(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      loginOrEmail: loginOrEmail ?? this.loginOrEmail,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (firstName.present) {
      map['firstName'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['lastName'] = Variable<String>(lastName.value);
    }
    if (loginOrEmail.present) {
      map['loginOrEmail'] = Variable<String>(loginOrEmail.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('loginOrEmail: $loginOrEmail, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskTable extends Task with TableInfo<$TaskTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startFromMeta = const VerificationMeta(
    'startFrom',
  );
  @override
  late final GeneratedColumn<String> startFrom = GeneratedColumn<String>(
    'startFrom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<String> endAt = GeneratedColumn<String>(
    'endAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<BigInt> startTime = GeneratedColumn<BigInt>(
    'startTime',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<BigInt> endTime = GeneratedColumn<BigInt>(
    'endTime',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskStateMeta = const VerificationMeta(
    'taskState',
  );
  @override
  late final GeneratedColumn<String> taskState = GeneratedColumn<String>(
    'taskState',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskDescriptionMeta = const VerificationMeta(
    'taskDescription',
  );
  @override
  late final GeneratedColumn<String> taskDescription = GeneratedColumn<String>(
    'taskDescription',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    startFrom,
    endAt,
    startTime,
    endTime,
    taskState,
    taskDescription,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('startFrom')) {
      context.handle(
        _startFromMeta,
        startFrom.isAcceptableOrUnknown(data['startFrom']!, _startFromMeta),
      );
    } else if (isInserting) {
      context.missing(_startFromMeta);
    }
    if (data.containsKey('endAt')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['endAt']!, _endAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('startTime')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['startTime']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('endTime')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['endTime']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('taskState')) {
      context.handle(
        _taskStateMeta,
        taskState.isAcceptableOrUnknown(data['taskState']!, _taskStateMeta),
      );
    } else if (isInserting) {
      context.missing(_taskStateMeta);
    }
    if (data.containsKey('taskDescription')) {
      context.handle(
        _taskDescriptionMeta,
        taskDescription.isAcceptableOrUnknown(
          data['taskDescription']!,
          _taskDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taskDescriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      startFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}startFrom'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endAt'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}startTime'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}endTime'],
      )!,
      taskState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}taskState'],
      )!,
      taskDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}taskDescription'],
      )!,
    );
  }

  @override
  $TaskTable createAlias(String alias) {
    return $TaskTable(attachedDatabase, alias);
  }
}

class TaskData extends DataClass implements Insertable<TaskData> {
  final int id;
  final String date;
  final String startFrom;
  final String endAt;
  final BigInt startTime;
  final BigInt endTime;
  final String taskState;
  final String taskDescription;
  const TaskData({
    required this.id,
    required this.date,
    required this.startFrom,
    required this.endAt,
    required this.startTime,
    required this.endTime,
    required this.taskState,
    required this.taskDescription,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['startFrom'] = Variable<String>(startFrom);
    map['endAt'] = Variable<String>(endAt);
    map['startTime'] = Variable<BigInt>(startTime);
    map['endTime'] = Variable<BigInt>(endTime);
    map['taskState'] = Variable<String>(taskState);
    map['taskDescription'] = Variable<String>(taskDescription);
    return map;
  }

  TaskCompanion toCompanion(bool nullToAbsent) {
    return TaskCompanion(
      id: Value(id),
      date: Value(date),
      startFrom: Value(startFrom),
      endAt: Value(endAt),
      startTime: Value(startTime),
      endTime: Value(endTime),
      taskState: Value(taskState),
      taskDescription: Value(taskDescription),
    );
  }

  factory TaskData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      startFrom: serializer.fromJson<String>(json['startFrom']),
      endAt: serializer.fromJson<String>(json['endAt']),
      startTime: serializer.fromJson<BigInt>(json['startTime']),
      endTime: serializer.fromJson<BigInt>(json['endTime']),
      taskState: serializer.fromJson<String>(json['taskState']),
      taskDescription: serializer.fromJson<String>(json['taskDescription']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'startFrom': serializer.toJson<String>(startFrom),
      'endAt': serializer.toJson<String>(endAt),
      'startTime': serializer.toJson<BigInt>(startTime),
      'endTime': serializer.toJson<BigInt>(endTime),
      'taskState': serializer.toJson<String>(taskState),
      'taskDescription': serializer.toJson<String>(taskDescription),
    };
  }

  TaskData copyWith({
    int? id,
    String? date,
    String? startFrom,
    String? endAt,
    BigInt? startTime,
    BigInt? endTime,
    String? taskState,
    String? taskDescription,
  }) => TaskData(
    id: id ?? this.id,
    date: date ?? this.date,
    startFrom: startFrom ?? this.startFrom,
    endAt: endAt ?? this.endAt,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    taskState: taskState ?? this.taskState,
    taskDescription: taskDescription ?? this.taskDescription,
  );
  TaskData copyWithCompanion(TaskCompanion data) {
    return TaskData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      startFrom: data.startFrom.present ? data.startFrom.value : this.startFrom,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      taskState: data.taskState.present ? data.taskState.value : this.taskState,
      taskDescription: data.taskDescription.present
          ? data.taskDescription.value
          : this.taskDescription,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('startFrom: $startFrom, ')
          ..write('endAt: $endAt, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('taskState: $taskState, ')
          ..write('taskDescription: $taskDescription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    startFrom,
    endAt,
    startTime,
    endTime,
    taskState,
    taskDescription,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.date == this.date &&
          other.startFrom == this.startFrom &&
          other.endAt == this.endAt &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.taskState == this.taskState &&
          other.taskDescription == this.taskDescription);
}

class TaskCompanion extends UpdateCompanion<TaskData> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> startFrom;
  final Value<String> endAt;
  final Value<BigInt> startTime;
  final Value<BigInt> endTime;
  final Value<String> taskState;
  final Value<String> taskDescription;
  const TaskCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.startFrom = const Value.absent(),
    this.endAt = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.taskState = const Value.absent(),
    this.taskDescription = const Value.absent(),
  });
  TaskCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String startFrom,
    required String endAt,
    required BigInt startTime,
    required BigInt endTime,
    required String taskState,
    required String taskDescription,
  }) : date = Value(date),
       startFrom = Value(startFrom),
       endAt = Value(endAt),
       startTime = Value(startTime),
       endTime = Value(endTime),
       taskState = Value(taskState),
       taskDescription = Value(taskDescription);
  static Insertable<TaskData> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? startFrom,
    Expression<String>? endAt,
    Expression<BigInt>? startTime,
    Expression<BigInt>? endTime,
    Expression<String>? taskState,
    Expression<String>? taskDescription,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (startFrom != null) 'startFrom': startFrom,
      if (endAt != null) 'endAt': endAt,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (taskState != null) 'taskState': taskState,
      if (taskDescription != null) 'taskDescription': taskDescription,
    });
  }

  TaskCompanion copyWith({
    Value<int>? id,
    Value<String>? date,
    Value<String>? startFrom,
    Value<String>? endAt,
    Value<BigInt>? startTime,
    Value<BigInt>? endTime,
    Value<String>? taskState,
    Value<String>? taskDescription,
  }) {
    return TaskCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      startFrom: startFrom ?? this.startFrom,
      endAt: endAt ?? this.endAt,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      taskState: taskState ?? this.taskState,
      taskDescription: taskDescription ?? this.taskDescription,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (startFrom.present) {
      map['startFrom'] = Variable<String>(startFrom.value);
    }
    if (endAt.present) {
      map['endAt'] = Variable<String>(endAt.value);
    }
    if (startTime.present) {
      map['startTime'] = Variable<BigInt>(startTime.value);
    }
    if (endTime.present) {
      map['endTime'] = Variable<BigInt>(endTime.value);
    }
    if (taskState.present) {
      map['taskState'] = Variable<String>(taskState.value);
    }
    if (taskDescription.present) {
      map['taskDescription'] = Variable<String>(taskDescription.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('startFrom: $startFrom, ')
          ..write('endAt: $endAt, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('taskState: $taskState, ')
          ..write('taskDescription: $taskDescription')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserTable user = $UserTable(this);
  late final $TaskTable task = $TaskTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [user, task];
}

typedef $$UserTableCreateCompanionBuilder =
    UserCompanion Function({
      required String firstName,
      required String lastName,
      required String loginOrEmail,
      Value<int> rowid,
    });
typedef $$UserTableUpdateCompanionBuilder =
    UserCompanion Function({
      Value<String> firstName,
      Value<String> lastName,
      Value<String> loginOrEmail,
      Value<int> rowid,
    });

class $$UserTableFilterComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loginOrEmail => $composableBuilder(
    column: $table.loginOrEmail,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserTableOrderingComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loginOrEmail => $composableBuilder(
    column: $table.loginOrEmail,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get loginOrEmail => $composableBuilder(
    column: $table.loginOrEmail,
    builder: (column) => column,
  );
}

class $$UserTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserTable,
          UserData,
          $$UserTableFilterComposer,
          $$UserTableOrderingComposer,
          $$UserTableAnnotationComposer,
          $$UserTableCreateCompanionBuilder,
          $$UserTableUpdateCompanionBuilder,
          (UserData, BaseReferences<_$AppDatabase, $UserTable, UserData>),
          UserData,
          PrefetchHooks Function()
        > {
  $$UserTableTableManager(_$AppDatabase db, $UserTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> loginOrEmail = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserCompanion(
                firstName: firstName,
                lastName: lastName,
                loginOrEmail: loginOrEmail,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String firstName,
                required String lastName,
                required String loginOrEmail,
                Value<int> rowid = const Value.absent(),
              }) => UserCompanion.insert(
                firstName: firstName,
                lastName: lastName,
                loginOrEmail: loginOrEmail,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserTable,
      UserData,
      $$UserTableFilterComposer,
      $$UserTableOrderingComposer,
      $$UserTableAnnotationComposer,
      $$UserTableCreateCompanionBuilder,
      $$UserTableUpdateCompanionBuilder,
      (UserData, BaseReferences<_$AppDatabase, $UserTable, UserData>),
      UserData,
      PrefetchHooks Function()
    >;
typedef $$TaskTableCreateCompanionBuilder =
    TaskCompanion Function({
      Value<int> id,
      required String date,
      required String startFrom,
      required String endAt,
      required BigInt startTime,
      required BigInt endTime,
      required String taskState,
      required String taskDescription,
    });
typedef $$TaskTableUpdateCompanionBuilder =
    TaskCompanion Function({
      Value<int> id,
      Value<String> date,
      Value<String> startFrom,
      Value<String> endAt,
      Value<BigInt> startTime,
      Value<BigInt> endTime,
      Value<String> taskState,
      Value<String> taskDescription,
    });

class $$TaskTableFilterComposer extends Composer<_$AppDatabase, $TaskTable> {
  $$TaskTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startFrom => $composableBuilder(
    column: $table.startFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskState => $composableBuilder(
    column: $table.taskState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskDescription => $composableBuilder(
    column: $table.taskDescription,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaskTableOrderingComposer extends Composer<_$AppDatabase, $TaskTable> {
  $$TaskTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startFrom => $composableBuilder(
    column: $table.startFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskState => $composableBuilder(
    column: $table.taskState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskDescription => $composableBuilder(
    column: $table.taskDescription,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaskTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskTable> {
  $$TaskTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get startFrom =>
      $composableBuilder(column: $table.startFrom, builder: (column) => column);

  GeneratedColumn<String> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<BigInt> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<BigInt> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get taskState =>
      $composableBuilder(column: $table.taskState, builder: (column) => column);

  GeneratedColumn<String> get taskDescription => $composableBuilder(
    column: $table.taskDescription,
    builder: (column) => column,
  );
}

class $$TaskTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaskTable,
          TaskData,
          $$TaskTableFilterComposer,
          $$TaskTableOrderingComposer,
          $$TaskTableAnnotationComposer,
          $$TaskTableCreateCompanionBuilder,
          $$TaskTableUpdateCompanionBuilder,
          (TaskData, BaseReferences<_$AppDatabase, $TaskTable, TaskData>),
          TaskData,
          PrefetchHooks Function()
        > {
  $$TaskTableTableManager(_$AppDatabase db, $TaskTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> startFrom = const Value.absent(),
                Value<String> endAt = const Value.absent(),
                Value<BigInt> startTime = const Value.absent(),
                Value<BigInt> endTime = const Value.absent(),
                Value<String> taskState = const Value.absent(),
                Value<String> taskDescription = const Value.absent(),
              }) => TaskCompanion(
                id: id,
                date: date,
                startFrom: startFrom,
                endAt: endAt,
                startTime: startTime,
                endTime: endTime,
                taskState: taskState,
                taskDescription: taskDescription,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String date,
                required String startFrom,
                required String endAt,
                required BigInt startTime,
                required BigInt endTime,
                required String taskState,
                required String taskDescription,
              }) => TaskCompanion.insert(
                id: id,
                date: date,
                startFrom: startFrom,
                endAt: endAt,
                startTime: startTime,
                endTime: endTime,
                taskState: taskState,
                taskDescription: taskDescription,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaskTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaskTable,
      TaskData,
      $$TaskTableFilterComposer,
      $$TaskTableOrderingComposer,
      $$TaskTableAnnotationComposer,
      $$TaskTableCreateCompanionBuilder,
      $$TaskTableUpdateCompanionBuilder,
      (TaskData, BaseReferences<_$AppDatabase, $TaskTable, TaskData>),
      TaskData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableTableManager get user => $$UserTableTableManager(_db, _db.user);
  $$TaskTableTableManager get task => $$TaskTableTableManager(_db, _db.task);
}
