import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/network_info.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final NetworkInfo _networkInfo = GetIt.instance<NetworkInfo>();

  ConnectivityCubit() : super(ConnectivityInitial()) {
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    emit(ConnectivityLoading());
    final isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      emit(ConnectivityConnected());
    } else {
      emit(ConnectivityDisconnected());
    }
  }
}
