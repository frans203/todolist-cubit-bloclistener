import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todo_cubit/models/todo_model.dart";

part "filtered_todos_state.dart";

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  //this is most like an unique useEffect for each cubit we got
  //we need constant info about what is happening among all this cubit states
  final List<Todo> initialTodos;
  FilteredTodosCubit({required this.initialTodos})
      : super(FilteredTodosState(filteredTodos: initialTodos));

  void setFilteredTodos(Filter filter, List<Todo> todos, String searchTerm) {
    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;

      case Filter.completed:
        _filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;

      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodos: _filteredTodos));
  }
}
