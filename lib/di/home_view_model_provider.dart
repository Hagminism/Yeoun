import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../feature/home/presentation/screen/home_state.dart';
import '../feature/home/presentation/screen/home_view_model.dart';

final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeState>(HomeViewModel.new);
