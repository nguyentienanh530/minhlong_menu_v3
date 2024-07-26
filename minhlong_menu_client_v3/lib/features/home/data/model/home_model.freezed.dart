// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return _HomeModel.fromJson(json);
}

/// @nodoc
mixin _$HomeModel {
  @JsonKey(name: 'banners')
  List<BannerModel> get banners => throw _privateConstructorUsedError;
  @JsonKey(name: 'categories')
  List<CategoryModel> get categories => throw _privateConstructorUsedError;
  @JsonKey(name: 'newFoods')
  List<FoodItem> get newFoods => throw _privateConstructorUsedError;
  @JsonKey(name: 'popularFoods')
  List<FoodItem> get popularFoods => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeModelCopyWith<HomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeModelCopyWith<$Res> {
  factory $HomeModelCopyWith(HomeModel value, $Res Function(HomeModel) then) =
      _$HomeModelCopyWithImpl<$Res, HomeModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'banners') List<BannerModel> banners,
      @JsonKey(name: 'categories') List<CategoryModel> categories,
      @JsonKey(name: 'newFoods') List<FoodItem> newFoods,
      @JsonKey(name: 'popularFoods') List<FoodItem> popularFoods});
}

/// @nodoc
class _$HomeModelCopyWithImpl<$Res, $Val extends HomeModel>
    implements $HomeModelCopyWith<$Res> {
  _$HomeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? banners = null,
    Object? categories = null,
    Object? newFoods = null,
    Object? popularFoods = null,
  }) {
    return _then(_value.copyWith(
      banners: null == banners
          ? _value.banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<BannerModel>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      newFoods: null == newFoods
          ? _value.newFoods
          : newFoods // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
      popularFoods: null == popularFoods
          ? _value.popularFoods
          : popularFoods // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeModelImplCopyWith<$Res>
    implements $HomeModelCopyWith<$Res> {
  factory _$$HomeModelImplCopyWith(
          _$HomeModelImpl value, $Res Function(_$HomeModelImpl) then) =
      __$$HomeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'banners') List<BannerModel> banners,
      @JsonKey(name: 'categories') List<CategoryModel> categories,
      @JsonKey(name: 'newFoods') List<FoodItem> newFoods,
      @JsonKey(name: 'popularFoods') List<FoodItem> popularFoods});
}

/// @nodoc
class __$$HomeModelImplCopyWithImpl<$Res>
    extends _$HomeModelCopyWithImpl<$Res, _$HomeModelImpl>
    implements _$$HomeModelImplCopyWith<$Res> {
  __$$HomeModelImplCopyWithImpl(
      _$HomeModelImpl _value, $Res Function(_$HomeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? banners = null,
    Object? categories = null,
    Object? newFoods = null,
    Object? popularFoods = null,
  }) {
    return _then(_$HomeModelImpl(
      banners: null == banners
          ? _value._banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<BannerModel>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      newFoods: null == newFoods
          ? _value._newFoods
          : newFoods // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
      popularFoods: null == popularFoods
          ? _value._popularFoods
          : popularFoods // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeModelImpl implements _HomeModel {
  _$HomeModelImpl(
      {@JsonKey(name: 'banners')
      final List<BannerModel> banners = const <BannerModel>[],
      @JsonKey(name: 'categories')
      final List<CategoryModel> categories = const <CategoryModel>[],
      @JsonKey(name: 'newFoods')
      final List<FoodItem> newFoods = const <FoodItem>[],
      @JsonKey(name: 'popularFoods')
      final List<FoodItem> popularFoods = const <FoodItem>[]})
      : _banners = banners,
        _categories = categories,
        _newFoods = newFoods,
        _popularFoods = popularFoods;

  factory _$HomeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeModelImplFromJson(json);

  final List<BannerModel> _banners;
  @override
  @JsonKey(name: 'banners')
  List<BannerModel> get banners {
    if (_banners is EqualUnmodifiableListView) return _banners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_banners);
  }

  final List<CategoryModel> _categories;
  @override
  @JsonKey(name: 'categories')
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<FoodItem> _newFoods;
  @override
  @JsonKey(name: 'newFoods')
  List<FoodItem> get newFoods {
    if (_newFoods is EqualUnmodifiableListView) return _newFoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newFoods);
  }

  final List<FoodItem> _popularFoods;
  @override
  @JsonKey(name: 'popularFoods')
  List<FoodItem> get popularFoods {
    if (_popularFoods is EqualUnmodifiableListView) return _popularFoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_popularFoods);
  }

  @override
  String toString() {
    return 'HomeModel(banners: $banners, categories: $categories, newFoods: $newFoods, popularFoods: $popularFoods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeModelImpl &&
            const DeepCollectionEquality().equals(other._banners, _banners) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._newFoods, _newFoods) &&
            const DeepCollectionEquality()
                .equals(other._popularFoods, _popularFoods));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_banners),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_newFoods),
      const DeepCollectionEquality().hash(_popularFoods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeModelImplCopyWith<_$HomeModelImpl> get copyWith =>
      __$$HomeModelImplCopyWithImpl<_$HomeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeModelImplToJson(
      this,
    );
  }
}

abstract class _HomeModel implements HomeModel {
  factory _HomeModel(
          {@JsonKey(name: 'banners') final List<BannerModel> banners,
          @JsonKey(name: 'categories') final List<CategoryModel> categories,
          @JsonKey(name: 'newFoods') final List<FoodItem> newFoods,
          @JsonKey(name: 'popularFoods') final List<FoodItem> popularFoods}) =
      _$HomeModelImpl;

  factory _HomeModel.fromJson(Map<String, dynamic> json) =
      _$HomeModelImpl.fromJson;

  @override
  @JsonKey(name: 'banners')
  List<BannerModel> get banners;
  @override
  @JsonKey(name: 'categories')
  List<CategoryModel> get categories;
  @override
  @JsonKey(name: 'newFoods')
  List<FoodItem> get newFoods;
  @override
  @JsonKey(name: 'popularFoods')
  List<FoodItem> get popularFoods;
  @override
  @JsonKey(ignore: true)
  _$$HomeModelImplCopyWith<_$HomeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
