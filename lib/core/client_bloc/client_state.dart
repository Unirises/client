part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();
}

class ClientInitial extends ClientState {
  @override
  List<Object> get props => [];
}

class ClientLoaded extends ClientState {
  ClientLoaded(this.client);
  final Client client;

  @override
  List<Object> get props => [client];
}
