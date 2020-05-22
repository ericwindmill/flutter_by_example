import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ErrorBuilder<T> = T Function(BuildContext context, Object error);
DeferredStartListening<Stream<T>, T> _streamStartListening<T>({
  T initialData,
  ErrorBuilder<T> catchError,
}) {
  return (e, setState, controller, __) {
    if (!e.hasValue) {
      setState(initialData);
    }
    if (controller == null) {
      return () {};
    }
    final sub = controller.listen(
      setState,
      onError: (dynamic error) {
        if (catchError != null) {
          setState(catchError(e, error));
        } else {
          FlutterError.reportError(
            FlutterErrorDetails(
              library: 'provider',
              exception: FlutterError('''
An exception was throw by ${controller.runtimeType} listened by
StreamProvider<$T>, but no `catchError` was provided.
Exception:
$error
'''),
            ),
          );
        }
      },
    );
    return sub.cancel;
  };
}

class StreamProvider<T> extends DeferredInheritedProvider<Stream<T>, T> {
  StreamProvider({
    Key key,
    @required Create<Stream<T>> create,
    T initialData,
    ErrorBuilder<T> catchError,
    UpdateShouldNotify<T> updateShouldNotify,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  })  : assert(create != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          updateShouldNotify: updateShouldNotify,
          startListening: _streamStartListening(
            catchError: catchError,
            initialData: initialData,
          ),
          child: child,
        );
  StreamProvider.value({
    Key key,
    @required Stream<T> value,
    T initialData,
    ErrorBuilder<T> catchError,
    UpdateShouldNotify<T> updateShouldNotify,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  }) : super.value(
          key: key,
          lazy: lazy,
          builder: builder,
          value: value,
          updateShouldNotify: updateShouldNotify,
          startListening: _streamStartListening(
            catchError: catchError,
            initialData: initialData,
          ),
          child: child,
        );
}

DeferredStartListening<Future<T>, T> _futureStartListening<T>({
  T initialData,
  ErrorBuilder<T> catchError,
}) {
  return (e, setState, controller, __) {
    if (!e.hasValue) {
      setState(initialData);
    }
    var canceled = false;
    controller?.then(
      (value) {
        if (canceled) return;
        setState(value);
      },
      onError: (dynamic error) {
        if (canceled) return;
        if (catchError != null) {
          setState(catchError(e, error));
        } else {
          FlutterError.reportError(
            FlutterErrorDetails(
              library: 'provider',
              exception: FlutterError('''
An exception was throw by ${controller.runtimeType} listened by
FutureProvider<$T>, but no `catchError` was provided.
Exception:
$error
'''),
            ),
          );
        }
      },
    );
    return () => canceled = true;
  };
}

class FutureProvider<T> extends DeferredInheritedProvider<Future<T>, T> {
  FutureProvider({
    Key key,
    @required Create<Future<T>> create,
    T initialData,
    ErrorBuilder<T> catchError,
    UpdateShouldNotify<T> updateShouldNotify,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  })  : assert(create != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          updateShouldNotify: updateShouldNotify,
          startListening: _futureStartListening(
            catchError: catchError,
            initialData: initialData,
          ),
          child: child,
        );
  FutureProvider.value({
    Key key,
    @required Future<T> value,
    T initialData,
    ErrorBuilder<T> catchError,
    UpdateShouldNotify<T> updateShouldNotify,
    ValueWidgetBuilder<T> builder,
    Widget child,
  }) : super.value(
          key: key,
          builder: builder,
          lazy: false,
          value: value,
          updateShouldNotify: updateShouldNotify,
          startListening: _futureStartListening(
            catchError: catchError,
            initialData: initialData,
          ),
          child: child,
        );
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends ListenableProvider<T> {
  static void _dispose(BuildContext context, ChangeNotifier notifier) {
    notifier?.dispose();
  }

  ChangeNotifierProvider({
    Key key,
    @required Create<T> create,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          dispose: _dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
  ChangeNotifierProvider.value({
    Key key,
    @required T value,
    ValueWidgetBuilder<T> builder,
    Widget child,
  }) : super.value(
          key: key,
          builder: builder,
          value: value,
          child: child,
        );
}

class ChangeNotifierProxyProvider<T, R extends ChangeNotifier>
    extends ListenableProxyProvider<T, R> {
  ChangeNotifierProxyProvider({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder<T, R> update,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          update: update,
          dispose: ChangeNotifierProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class ChangeNotifierProxyProvider0<R extends ChangeNotifier> extends ListenableProxyProvider0<R> {
  ChangeNotifierProxyProvider0({
    Key key,
    @required Create<R> create,
    @required R Function(BuildContext, R value) update,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          update: update,
          dispose: ChangeNotifierProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class ChangeNotifierProxyProvider2<T, T2, R extends ChangeNotifier>
    extends ListenableProxyProvider2<T, T2, R> {
  ChangeNotifierProxyProvider2({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder2<T, T2, R> update,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          update: update,
          dispose: ChangeNotifierProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class ChangeNotifierProxyProvider3<T, T2, T3, R extends ChangeNotifier>
    extends ListenableProxyProvider3<T, T2, T3, R> {
  ChangeNotifierProxyProvider3({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder3<T, T2, T3, R> update,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          update: update,
          dispose: ChangeNotifierProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class ChangeNotifierProxyProvider4<T, T2, T3, T4, R extends ChangeNotifier>
    extends ListenableProxyProvider4<T, T2, T3, T4, R> {
  ChangeNotifierProxyProvider4({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder4<T, T2, T3, T4, R> update,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          update: update,
          dispose: ChangeNotifierProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class ChangeNotifierProxyProvider5<T, T2, T3, T4, T5, R extends ChangeNotifier>
    extends ListenableProxyProvider5<T, T2, T3, T4, T5, R> {
  ChangeNotifierProxyProvider5({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder5<T, T2, T3, T4, T5, R> update,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          update: update,
          dispose: ChangeNotifierProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class ChangeNotifierProxyProvider6<T, T2, T3, T4, T5, T6, R extends ChangeNotifier>
    extends ListenableProxyProvider6<T, T2, T3, T4, T5, T6, R> {
  ChangeNotifierProxyProvider6({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder6<T, T2, T3, T4, T5, T6, R> update,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          update: update,
          dispose: ChangeNotifierProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class Consumer<T> extends SingleChildStatelessWidget {
  Consumer({
    Key key,
    @required this.builder,
    Widget child,
  })  : assert(builder != null),
        super(key: key, child: child);
  final Widget Function(BuildContext context, T value, Widget child) builder;
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return builder(
      context,
      Provider.of<T>(context),
      child,
    );
  }
}

class Consumer2<A, B> extends SingleChildStatelessWidget {
  Consumer2({
    Key key,
    @required this.builder,
    Widget child,
  })  : assert(builder != null),
        super(key: key, child: child);
  final Widget Function(BuildContext context, A value, B value2, Widget child) builder;
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return builder(
      context,
      Provider.of<A>(context),
      Provider.of<B>(context),
      child,
    );
  }
}

class Consumer3<A, B, C> extends SingleChildStatelessWidget {
  Consumer3({
    Key key,
    @required this.builder,
    Widget child,
  })  : assert(builder != null),
        super(key: key, child: child);
  final Widget Function(BuildContext context, A value, B value2, C value3, Widget child) builder;
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return builder(
      context,
      Provider.of<A>(context),
      Provider.of<B>(context),
      Provider.of<C>(context),
      child,
    );
  }
}

class Consumer4<A, B, C, D> extends SingleChildStatelessWidget {
  Consumer4({
    Key key,
    @required this.builder,
    Widget child,
  })  : assert(builder != null),
        super(key: key, child: child);
  final Widget Function(
    BuildContext context,
    A value,
    B value2,
    C value3,
    D value4,
    Widget child,
  ) builder;
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return builder(
      context,
      Provider.of<A>(context),
      Provider.of<B>(context),
      Provider.of<C>(context),
      Provider.of<D>(context),
      child,
    );
  }
}

class Consumer5<A, B, C, D, E> extends SingleChildStatelessWidget {
  Consumer5({
    Key key,
    @required this.builder,
    Widget child,
  })  : assert(builder != null),
        super(key: key, child: child);
  final Widget Function(
    BuildContext context,
    A value,
    B value2,
    C value3,
    D value4,
    E value5,
    Widget child,
  ) builder;
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return builder(
      context,
      Provider.of<A>(context),
      Provider.of<B>(context),
      Provider.of<C>(context),
      Provider.of<D>(context),
      Provider.of<E>(context),
      child,
    );
  }
}

class Consumer6<A, B, C, D, E, F> extends SingleChildStatelessWidget {
  Consumer6({
    Key key,
    @required this.builder,
    Widget child,
  })  : assert(builder != null),
        super(key: key, child: child);
  final Widget Function(
    BuildContext context,
    A value,
    B value2,
    C value3,
    D value4,
    E value5,
    F value6,
    Widget child,
  ) builder;
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return builder(
      context,
      Provider.of<A>(context),
      Provider.of<B>(context),
      Provider.of<C>(context),
      Provider.of<D>(context),
      Provider.of<E>(context),
      Provider.of<F>(context),
      child,
    );
  }
}

typedef DeferredStartListening<T, R> = VoidCallback Function(
  InheritedContext<R> context,
  void Function(R value) setState,
  T controller,
  R value,
);

class DeferredInheritedProvider<T, R> extends InheritedProvider<R> {
  DeferredInheritedProvider({
    Key key,
    @required Create<T> create,
    Dispose<T> dispose,
    @required DeferredStartListening<T, R> startListening,
    UpdateShouldNotify<R> updateShouldNotify,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super._constructor(
          key: key,
          child: child,
          lazy: lazy,
          builder: builder,
          delegate: _CreateDeferredInheritedProvider(
            create: create,
            dispose: dispose,
            updateShouldNotify: updateShouldNotify,
            startListening: startListening,
          ),
        );
  DeferredInheritedProvider.value({
    Key key,
    @required T value,
    @required DeferredStartListening<T, R> startListening,
    UpdateShouldNotify<R> updateShouldNotify,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  }) : super._constructor(
          key: key,
          lazy: lazy,
          builder: builder,
          delegate: _ValueDeferredInheritedProvider<T, R>(
            value,
            updateShouldNotify,
            startListening,
          ),
          child: child,
        );
}

abstract class _DeferredDelegate<T, R> extends _Delegate<R> {
  _DeferredDelegate(this.updateShouldNotify, this.startListening);
  final UpdateShouldNotify<R> updateShouldNotify;
  final DeferredStartListening<T, R> startListening;
  @override
  _DeferredDelegateState<T, R, _DeferredDelegate<T, R>> createState();
}

abstract class _DeferredDelegateState<T, R, W extends _DeferredDelegate<T, R>>
    extends _DelegateState<R, W> {
  VoidCallback _removeListener;
  T get controller;
  R _value;
  @override
  R get value {
    element._isNotifyDependentsEnabled = false;
    _removeListener ??= delegate.startListening(
      element,
      setState,
      controller,
      _value,
    );
    element._isNotifyDependentsEnabled = true;
    assert(element.hasValue, '''
The callback "startListening" was called, but it left DeferredInhertitedProviderElement<$T, $R>
in an unitialized state.
It is necessary for "startListening" to call "setState" at least once the very
first time "value" is requested.
To fix, consider:
DeferredInheritedProvider(
  ...,
  startListening: (element, setState, controller, value) {
    if (!element.hasValue) {
    }
    ...
  }
)
    ''');
    assert(_removeListener != null);
    return _value;
  }

  @override
  void dispose() {
    super.dispose();
    _removeListener?.call();
  }

  bool get isLoaded => _removeListener != null;
  bool _hasValue = false;
  @override
  bool get hasValue => _hasValue;
  void setState(R value) {
    if (_hasValue) {
      final shouldNotify = delegate.updateShouldNotify != null
          ? delegate.updateShouldNotify(_value, value)
          : _value != value;
      if (shouldNotify) {
        element.markNeedsNotifyDependents();
      }
    }
    _hasValue = true;
    _value = value;
  }
}

class _CreateDeferredInheritedProvider<T, R> extends _DeferredDelegate<T, R> {
  _CreateDeferredInheritedProvider({
    @required this.create,
    this.dispose,
    UpdateShouldNotify<R> updateShouldNotify,
    DeferredStartListening<T, R> startListening,
  }) : super(updateShouldNotify, startListening);
  final Create<T> create;
  final Dispose<T> dispose;
  @override
  _CreateDeferredInheritedProviderElement<T, R> createState() {
    return _CreateDeferredInheritedProviderElement<T, R>();
  }
}

class _CreateDeferredInheritedProviderElement<T, R>
    extends _DeferredDelegateState<T, R, _CreateDeferredInheritedProvider<T, R>> {
  bool _didBuild = false;
  T _controller;
  @override
  T get controller {
    if (!_didBuild) {
      assert(debugSetInheritedLock(true));
      _controller = delegate.create(element);
      _didBuild = true;
    }
    return _controller;
  }

  @override
  void dispose() {
    super.dispose();
    if (_didBuild) {
      delegate.dispose?.call(element, _controller);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    if (isLoaded) {
      properties
        ..add(DiagnosticsProperty('controller', controller))
        ..add(DiagnosticsProperty('value', value));
    } else {
      properties
        ..add(
          FlagProperty(
            'controller',
            value: true,
            showName: true,
            ifTrue: '<not yet loaded>',
          ),
        )
        ..add(
          FlagProperty(
            'value',
            value: true,
            showName: true,
            ifTrue: '<not yet loaded>',
          ),
        );
    }
  }
}

class _ValueDeferredInheritedProvider<T, R> extends _DeferredDelegate<T, R> {
  _ValueDeferredInheritedProvider(
    this.value,
    UpdateShouldNotify<R> updateShouldNotify,
    DeferredStartListening<T, R> startListening,
  ) : super(updateShouldNotify, startListening);
  final T value;
  @override
  _ValueDeferredInheritedProviderState<T, R> createState() {
    return _ValueDeferredInheritedProviderState();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', value));
  }
}

class _ValueDeferredInheritedProviderState<T, R>
    extends _DeferredDelegateState<T, R, _ValueDeferredInheritedProvider<T, R>> {
  @override
  bool willUpdateDelegate(_ValueDeferredInheritedProvider<T, R> oldDelegate) {
    if (delegate.value != oldDelegate.value) {
      if (_removeListener != null) {
        _removeListener();
        _removeListener = null;
      }
      return true;
    }
    return false;
  }

  @override
  T get controller => delegate.value;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    if (_removeListener != null) {
      properties.add(DiagnosticsProperty('value', value));
    } else {
      properties.add(
        FlagProperty(
          'value',
          value: true,
          showName: true,
          ifTrue: '<not yet loaded>',
        ),
      );
    }
  }
}

typedef UpdateShouldNotify<T> = bool Function(T previous, T current);
typedef Create<T> = T Function(BuildContext context);
typedef Dispose<T> = void Function(BuildContext context, T value);
typedef StartListening<T> = VoidCallback Function(InheritedContext<T> element, T value);

class InheritedProvider<T> extends SingleChildStatelessWidget {
  InheritedProvider({
    Key key,
    Create<T> create,
    T update(BuildContext context, T value),
    UpdateShouldNotify<T> updateShouldNotify,
    void Function(T value) debugCheckInvalidValueType,
    StartListening<T> startListening,
    Dispose<T> dispose,
    ValueWidgetBuilder<T> builder,
    bool lazy,
    Widget child,
  })  : _lazy = lazy,
        _builder = builder,
        _delegate = _CreateInheritedProvider(
          create: create,
          update: update,
          updateShouldNotify: updateShouldNotify,
          debugCheckInvalidValueType: debugCheckInvalidValueType,
          startListening: startListening,
          dispose: dispose,
        ),
        super(key: key, child: child);
  InheritedProvider.value({
    Key key,
    @required T value,
    UpdateShouldNotify<T> updateShouldNotify,
    StartListening<T> startListening,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  })  : _lazy = lazy,
        _builder = builder,
        _delegate = _ValueInheritedProvider(
          value: value,
          updateShouldNotify: updateShouldNotify,
          startListening: startListening,
        ),
        super(key: key, child: child);
  InheritedProvider._constructor({
    Key key,
    _Delegate<T> delegate,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  })  : _lazy = lazy,
        _builder = builder,
        _delegate = delegate,
        super(key: key, child: child);
  final _Delegate<T> _delegate;
  final bool _lazy;
  final ValueWidgetBuilder<T> _builder;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _delegate.debugFillProperties(properties);
  }

  @override
  _InheritedProviderElement<T> createElement() {
    return _InheritedProviderElement<T>(this);
  }

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return _DefaultInheritedProviderScope<T>(
      owner: this,
      child: _builder != null
          ? Builder(
              builder: (context) {
                return _builder(context, Provider.of<T>(context), child);
              },
            )
          : child,
    );
  }
}

class _InheritedProviderElement<T> extends SingleChildStatelessElement {
  _InheritedProviderElement(InheritedProvider<T> widget) : super(widget);
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    visitChildren((e) {
      e.debugFillProperties(properties);
    });
  }
}

extension SelectContext on BuildContext {
  R select<T, R>(R selector(T value), [Object key]) {
    final inheritedElement = Provider._inheritedElementOf<T>(this);
    final selected = selector(inheritedElement.value);
    dependOnInheritedElement(
      inheritedElement,
      aspect: _SelectorAspect(selector, selected, key),
    );
    return selected;
  }
}

abstract class InheritedContext<T> extends BuildContext {
  T get value;
  void markNeedsNotifyDependents();
  bool get hasValue;
}

class _DefaultInheritedProviderScope<T> extends InheritedWidget {
  _DefaultInheritedProviderScope({
    this.owner,
    @required Widget child,
  }) : super(child: child);
  final InheritedProvider<T> owner;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  @override
  _DefaultInheritedProviderScopeElement<T> createElement() {
    return _DefaultInheritedProviderScopeElement<T>(this);
  }
}

class _DefaultInheritedProviderScopeElement<T> extends InheritedElement
    with _InheritedProviderScopeMixin<T> {
  _DefaultInheritedProviderScopeElement(_DefaultInheritedProviderScope<T> widget) : super(widget);
  @override
  _DefaultInheritedProviderScope<T> get widget => super.widget as _DefaultInheritedProviderScope<T>;
  @override
  bool _isLazy(_DefaultInheritedProviderScope<T> widget) => widget.owner._lazy;
  @override
  _DelegateState<T, _Delegate<T>> _delegateState;
  @override
  _Delegate<T> _widgetToDelegate(_DefaultInheritedProviderScope<T> widget) {
    return widget.owner._delegate;
  }

  @override
  void _mountDelegate() {
    _delegateState = widget.owner._delegate.createState()..element = this;
  }
}

class _SelectorAspect<T, R> {
  _SelectorAspect(this.selector, this.selected, [Object key]) : key = key ?? R;
  final R Function(T value) selector;
  final R selected;
  final Object key;
}

mixin _InheritedProviderScopeMixin<T> on InheritedElement implements InheritedContext<T> {
  bool _shouldNotifyDependents = false;
  bool _debugInheritLocked = false;
  bool _isNotifyDependentsEnabled = true;
  bool _firstBuild = true;
  Map<Element, Set<_SelectorAspect<T, Object>>> _debugSelectedKeysWithinFrame;
  @override
  void updateDependencies(Element dependent, Object aspect) {
    final dependencies = getDependencies(dependent) as Map<Object, _SelectorAspect<T, Object>>;
    if (dependencies != null && dependencies.isEmpty) return;
    if (aspect is _SelectorAspect<T, Object>) {
      assert(() {
        if (_debugSelectedKeysWithinFrame?.containsKey(dependent) ?? false) {
          final selectedKeysThisFrame = _debugSelectedKeysWithinFrame[dependent];
          final existingSelectorWithSameKey = selectedKeysThisFrame?.firstWhere((s) {
            return s.key == aspect.key;
          }, orElse: () => null);
          if (existingSelectorWithSameKey != null) {
            Element parentElement;
            visitAncestorElements((e) {
              parentElement = e;
              return false;
            });
            if (aspect.key is Type) {
              throw FlutterError.fromParts([
                ErrorSummary(
                    'Called `context.select<$T, ${aspect.key}>(...)` multiple times within the same frame.'),
                ErrorDescription(
                  'If `select` is called multiple times inside a widget, '
                  "then all calls must have a unique combination of provider's type + value's type, "
                  'or they must have a different "key".',
                ),
                ErrorDescription(
                  '''
```dart
context.select<$T, ${aspect.key}>((value) => value.something, 0);
context.select<$T, ${aspect.key}>((value) => value.somethingElse, 1);
```
''',
                ),
                ErrorSpacer(),
                DiagnosticsProperty('context', dependent),
                DiagnosticsProperty('provider obtained', parentElement.widget),
                DiagnosticsProperty("provider's value type", T),
                ErrorDescription('\nFailing selector:'),
                DiagnosticsProperty('- value selected', aspect.selected),
                DiagnosticsProperty('- value type', aspect.selected.runtimeType),
                ErrorDescription('\nConflicting selector:'),
                DiagnosticsProperty('- value selected', existingSelectorWithSameKey.selected),
                DiagnosticsProperty(
                    '- value type', existingSelectorWithSameKey.selected.runtimeType),
              ]);
            } else {
              throw FlutterError.fromParts([
                ErrorSummary(
                    '`select` was called multiple times with the same key on the same provider.'),
                ErrorDescription(
                  'If `select` is called multiple times inside a widget, '
                  "then all calls must have a unique combination of provider's type + value's type, "
                  'or they must have a different "key".',
                ),
                ErrorSpacer(),
                DiagnosticsProperty('context', dependent),
                DiagnosticsProperty('key', aspect.key),
                DiagnosticsProperty('provider obtained', parentElement.widget),
                DiagnosticsProperty("provider's value type", T),
                ErrorDescription('\nFailing selector:'),
                DiagnosticsProperty('- value selected', aspect.selected),
                DiagnosticsProperty('- value type', aspect.selected.runtimeType),
                ErrorDescription('\nConflicting selector:'),
                DiagnosticsProperty('- value selected', existingSelectorWithSameKey.selected),
                DiagnosticsProperty(
                    '- value type', existingSelectorWithSameKey.selected.runtimeType),
              ]);
            }
          }
        }
        return true;
      }());
      assert(() {
        _debugSelectedKeysWithinFrame ??= {};
        _debugSelectedKeysWithinFrame[dependent] ??= {};
        _debugSelectedKeysWithinFrame[dependent].add(aspect);
        Future.microtask(() {
          _debugSelectedKeysWithinFrame = null;
        });
        return true;
      }());
      final newDependencies = dependencies ?? HashMap();
      newDependencies[aspect.key] = aspect;
      setDependencies(dependent, newDependencies);
    } else {
      setDependencies(dependent, HashMap<Object, _SelectorAspect<T, Object>>());
    }
  }

  @override
  void notifyDependent(InheritedWidget oldWidget, Element dependent) {
    final dependencies = getDependencies(dependent) as Map<Object, _SelectorAspect<T, Object>>;
    var shouldNotify = false;
    if (dependencies != null) {
      if (dependencies.isEmpty) {
        shouldNotify = true;
      } else {
        for (final dependency in dependencies.values) {
          if (dependency.selector(value) != dependency.selected) {
            shouldNotify = true;
            break;
          }
        }
      }
    }
    if (shouldNotify) {
      dependent.didChangeDependencies();
    }
  }

  void _mountDelegate();
  _Delegate<T> _widgetToDelegate(covariant InheritedWidget widget);
  _DelegateState<T, _Delegate<T>> get _delegateState;
  bool _isLazy(covariant InheritedWidget widget);
  @override
  bool get hasValue => _delegateState.hasValue;
  @override
  void performRebuild() {
    if (_firstBuild) {
      _firstBuild = false;
      _mountDelegate();
    }
    super.performRebuild();
  }

  bool _updatedShouldNotify = false;
  bool _isBuildFromExternalSources = false;
  @override
  void update(InheritedWidget newWidget) {
    assert(() {
      if (_widgetToDelegate(widget).runtimeType != _widgetToDelegate(newWidget).runtimeType) {
        throw StateError('''Rebuilt $widget using a different constructor.
This is likely a mistake and is unsupported.
If you're in this situation, consider passing a `key` unique to each individual constructor.
''');
      }
      return true;
    }());
    _isBuildFromExternalSources = true;
    _updatedShouldNotify = _delegateState.willUpdateDelegate(_widgetToDelegate(newWidget));
    super.update(newWidget);
    _updatedShouldNotify = false;
  }

  @override
  void updated(InheritedWidget oldWidget) {
    super.updated(oldWidget);
    if (_updatedShouldNotify) {
      notifyClients(oldWidget);
    }
  }

  @override
  void didChangeDependencies() {
    _isBuildFromExternalSources = true;
    super.didChangeDependencies();
  }

  @override
  void unmount() {
    _delegateState.dispose();
    super.unmount();
  }

  @override
  void markNeedsNotifyDependents() {
    if (!_isNotifyDependentsEnabled) return;
    markNeedsBuild();
    _shouldNotifyDependents = true;
  }

  @override
  Widget build() {
    if (_isLazy(widget) == false) {}
    _delegateState.build(_isBuildFromExternalSources);
    _isBuildFromExternalSources = false;
    if (_shouldNotifyDependents) {
      _shouldNotifyDependents = false;
      notifyClients(widget);
    }
    return super.build();
  }

  bool _debugSetInheritedLock(bool value) {
    assert(() {
      _debugInheritLocked = value;
      return true;
    }());
    return true;
  }

  @override
  T get value => _delegateState.value;
  @override
  InheritedWidget dependOnInheritedElement(
    InheritedElement ancestor, {
    Object aspect,
  }) {
    assert(() {
      if (_debugInheritLocked) {
        throw FlutterError.fromParts(
          <DiagnosticsNode>[
            ErrorSummary(
              'Tried to listen to an InheritedWidget '
              'in a life-cycle that will never be called again.',
            ),
            ErrorDescription('''
This error typically happens when calling Provider.of with `listen` to `true`,
in a situation where listening to the provider doesn't make sense, such as:
- initState of a StatefulWidget
- the "create" callback of a provider
This is undesired because these life-cycles are called only once in the
lifetime of a widget. As such, while `listen` is `true`, the widget has
no mean to handle the update scenario.
To fix, consider:
- passing `listen: false` to `Provider.of`
- use a life-cycle that handles updates (like didChangeDependencies)
- use a provider that handles updates (like ProxyProvider).
'''),
          ],
        );
      }
      return true;
    }());
    return super.dependOnInheritedElement(ancestor, aspect: aspect);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _delegateState.debugFillProperties(properties);
  }
}

@immutable
abstract class _Delegate<T> {
  _DelegateState<T, _Delegate<T>> createState();
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {}
}

abstract class _DelegateState<T, D extends _Delegate<T>> {
  _InheritedProviderScopeMixin<T> element;
  T get value;
  D get delegate => element._widgetToDelegate(element.widget) as D;
  bool get hasValue;
  bool debugSetInheritedLock(bool value) {
    return element._debugSetInheritedLock(value);
  }

  bool willUpdateDelegate(D newDelegate) => false;
  void dispose() {}
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {}
  void build(bool isBuildFromExternalSources) {}
}

class _CreateInheritedProvider<T> extends _Delegate<T> {
  _CreateInheritedProvider({
    this.create,
    this.update,
    UpdateShouldNotify<T> updateShouldNotify,
    this.debugCheckInvalidValueType,
    this.startListening,
    this.dispose,
  })  : assert(create != null || update != null),
        _updateShouldNotify = updateShouldNotify;
  final Create<T> create;
  final T Function(BuildContext context, T value) update;
  final UpdateShouldNotify<T> _updateShouldNotify;
  final void Function(T value) debugCheckInvalidValueType;
  final StartListening<T> startListening;
  final Dispose<T> dispose;
  @override
  _CreateInheritedProviderState<T> createState() => _CreateInheritedProviderState();
}

bool _debugIsInInheritedProviderUpdate = false;

class _CreateInheritedProviderState<T> extends _DelegateState<T, _CreateInheritedProvider<T>> {
  VoidCallback _removeListener;
  bool _didInitValue = false;
  T _value;
  _CreateInheritedProvider<T> _previousWidget;
  @override
  T get value {
    if (!_didInitValue) {
      _didInitValue = true;
      if (delegate.create != null) {
        assert(debugSetInheritedLock(true));
        _value = delegate.create(element);
        assert(debugSetInheritedLock(false));
        assert(() {
          delegate.debugCheckInvalidValueType?.call(_value);
          return true;
        }());
      }
      if (delegate.update != null) {
        assert(() {
          _debugIsInInheritedProviderUpdate = true;
          return true;
        }());
        _value = delegate.update(element, _value);
        assert(() {
          _debugIsInInheritedProviderUpdate = false;
          return true;
        }());
        assert(() {
          delegate.debugCheckInvalidValueType?.call(_value);
          return true;
        }());
      }
    }
    element._isNotifyDependentsEnabled = false;
    _removeListener ??= delegate.startListening?.call(element, _value);
    element._isNotifyDependentsEnabled = true;
    assert(delegate.startListening == null || _removeListener != null);
    return _value;
  }

  @override
  void dispose() {
    super.dispose();
    _removeListener?.call();
    if (_didInitValue) {
      delegate.dispose?.call(element, _value);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    if (_didInitValue) {
      properties
        ..add(DiagnosticsProperty('value', value))
        ..add(
          FlagProperty(
            null,
            value: _removeListener != null,
            defaultValue: false,
            ifTrue: 'listening to value',
          ),
        );
    } else {
      properties.add(
        FlagProperty(
          'value',
          value: true,
          showName: true,
          ifTrue: '<not yet loaded>',
        ),
      );
    }
  }

  @override
  void build(bool isBuildFromExternalSources) {
    var shouldNotify = false;
    if (isBuildFromExternalSources && _didInitValue && delegate.update != null) {
      final previousValue = _value;
      _value = delegate.update(element, _value);
      if (delegate._updateShouldNotify != null) {
        shouldNotify = delegate._updateShouldNotify(previousValue, _value);
      } else {
        shouldNotify = _value != previousValue;
      }
      if (shouldNotify) {
        assert(() {
          delegate.debugCheckInvalidValueType?.call(_value);
          return true;
        }());
        if (_removeListener != null) {
          _removeListener();
          _removeListener = null;
        }
        _previousWidget?.dispose?.call(element, previousValue);
      }
    }
    if (shouldNotify) {
      element._shouldNotifyDependents = true;
    }
    _previousWidget = delegate;
    return super.build(isBuildFromExternalSources);
  }

  @override
  bool get hasValue => _didInitValue;
}

class _ValueInheritedProvider<T> extends _Delegate<T> {
  _ValueInheritedProvider({
    @required this.value,
    UpdateShouldNotify<T> updateShouldNotify,
    this.startListening,
  }) : _updateShouldNotify = updateShouldNotify;
  final T value;
  final UpdateShouldNotify<T> _updateShouldNotify;
  final StartListening<T> startListening;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('value', value));
  }

  @override
  _ValueInheritedProviderState<T> createState() {
    return _ValueInheritedProviderState<T>();
  }
}

class _ValueInheritedProviderState<T> extends _DelegateState<T, _ValueInheritedProvider<T>> {
  VoidCallback _removeListener;
  @override
  T get value {
    element._isNotifyDependentsEnabled = false;
    _removeListener ??= delegate.startListening?.call(element, delegate.value);
    element._isNotifyDependentsEnabled = true;
    assert(delegate.startListening == null || _removeListener != null);
    return delegate.value;
  }

  @override
  bool willUpdateDelegate(_ValueInheritedProvider<T> newDelegate) {
    bool shouldNotify;
    if (delegate._updateShouldNotify != null) {
      shouldNotify = delegate._updateShouldNotify(
        delegate.value,
        newDelegate.value,
      );
    } else {
      shouldNotify = newDelegate.value != delegate.value;
    }
    if (shouldNotify && _removeListener != null) {
      _removeListener();
      _removeListener = null;
    }
    return shouldNotify;
  }

  @override
  void dispose() {
    super.dispose();
    _removeListener?.call();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty(
        null,
        value: _removeListener != null,
        defaultValue: false,
        ifTrue: 'listening to value',
      ),
    );
  }

  @override
  bool get hasValue => true;
}

class ListenableProvider<T extends Listenable> extends InheritedProvider<T> {
  ListenableProvider({
    Key key,
    @required Create<T> create,
    Dispose<T> dispose,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  })  : assert(create != null),
        super(
          key: key,
          startListening: _startListening,
          create: create,
          dispose: dispose,
          debugCheckInvalidValueType: kReleaseMode
              ? null
              : (value) {
                  if (value is ChangeNotifier) {
                    // ignore: invalid_use_of_protected_member
                    assert(!value.hasListeners, '''
The default constructor of ListenableProvider/ChangeNotifierProvider
must create a new, unused Listenable.
If you want to reuse an existing Listenable, use the second constructor:
- DO use ChangeNotifierProvider.value to provider an existing ChangeNotifier:
MyChangeNotifier variable;
ChangeNotifierProvider.value(
  value: variable,
  child: ...
)
- DON'T reuse an existing ChangeNotifier using the default constructor.
MyChangeNotifier variable;
ChangeNotifierProvider(
  create: (_) => variable,
  child: ...
)
''');
                  }
                },
          lazy: lazy,
          builder: builder,
          child: child,
        );
  ListenableProvider.value({
    Key key,
    @required T value,
    UpdateShouldNotify<T> updateShouldNotify,
    ValueWidgetBuilder<T> builder,
    Widget child,
  }) : super.value(
          key: key,
          builder: builder,
          value: value,
          updateShouldNotify: updateShouldNotify,
          startListening: _startListening,
          child: child,
        );
  static VoidCallback _startListening(
    InheritedContext<Listenable> e,
    Listenable value,
  ) {
    value?.addListener(e.markNeedsNotifyDependents);
    return () => value?.removeListener(e.markNeedsNotifyDependents);
  }
}

class ListenableProxyProvider0<R extends Listenable> extends InheritedProvider<R> {
  ListenableProxyProvider0({
    Key key,
    @required Create<R> create,
    @required R Function(BuildContext, R previous) update,
    Dispose<R> dispose,
    UpdateShouldNotify<R> updateShouldNotify,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(create != null || update != null),
        super(
          key: key,
          create: create,
          update: update,
          lazy: lazy,
          builder: builder,
          dispose: dispose,
          updateShouldNotify: updateShouldNotify,
          startListening: ListenableProvider._startListening,
          debugCheckInvalidValueType: kReleaseMode
              ? null
              : (value) {
                  if (value is ChangeNotifier) {
                    // ignore: invalid_use_of_protected_member
                    assert(value.hasListeners != true);
                  }
                },
          child: child,
        );
}

class ListenableProxyProvider<T, R extends Listenable> extends ListenableProxyProvider0<R> {
  ListenableProxyProvider({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder<T, R> update,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(create != null || update != null),
        super(
          key: key,
          create: create,
          lazy: lazy,
          builder: builder,
          update: (context, previous) => update(
            context,
            Provider.of(context),
            previous,
          ),
          dispose: dispose,
          child: child,
        );
}

class ListenableProxyProvider2<T, T2, R extends Listenable> extends ListenableProxyProvider0<R> {
  ListenableProxyProvider2({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder2<T, T2, R> update,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(create != null || update != null),
        super(
          key: key,
          create: create,
          lazy: lazy,
          builder: builder,
          update: (context, previous) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            previous,
          ),
          dispose: dispose,
          child: child,
        );
}

class ListenableProxyProvider3<T, T2, T3, R extends Listenable>
    extends ListenableProxyProvider0<R> {
  ListenableProxyProvider3({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder3<T, T2, T3, R> update,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(create != null || update != null),
        super(
          key: key,
          create: create,
          lazy: lazy,
          builder: builder,
          update: (context, previous) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            previous,
          ),
          dispose: dispose,
          child: child,
        );
}

class ListenableProxyProvider4<T, T2, T3, T4, R extends Listenable>
    extends ListenableProxyProvider0<R> {
  ListenableProxyProvider4({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder4<T, T2, T3, T4, R> update,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(create != null || update != null),
        super(
          key: key,
          create: create,
          lazy: lazy,
          builder: builder,
          update: (context, previous) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            previous,
          ),
          dispose: dispose,
          child: child,
        );
}

class ListenableProxyProvider5<T, T2, T3, T4, T5, R extends Listenable>
    extends ListenableProxyProvider0<R> {
  ListenableProxyProvider5({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder5<T, T2, T3, T4, T5, R> update,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(create != null || update != null),
        super(
          key: key,
          create: create,
          lazy: lazy,
          builder: builder,
          update: (context, previous) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            previous,
          ),
          dispose: dispose,
          child: child,
        );
}

class ListenableProxyProvider6<T, T2, T3, T4, T5, T6, R extends Listenable>
    extends ListenableProxyProvider0<R> {
  ListenableProxyProvider6({
    Key key,
    @required Create<R> create,
    @required ProxyProviderBuilder6<T, T2, T3, T4, T5, T6, R> update,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(create != null || update != null),
        super(
          key: key,
          create: create,
          lazy: lazy,
          builder: builder,
          update: (context, previous) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            previous,
          ),
          dispose: dispose,
          child: child,
        );
}

/// A widget that simplify the writing of deeply nested widget trees.
///
/// It relies on the new kind of widget [SingleChildWidget], which has two
/// concrete implementations:
/// - [SingleChildStatelessWidget]
/// - [SingleChildStatefulWidget]
///
/// They are both respectively a [SingleChildWidget] variant of [StatelessWidget]
/// and [StatefulWidget].
///
/// The difference between a widget and its single-child variant is that they have
/// a custom `build` method that takes an extra parameter.
///
/// As such, a `StatelessWidget` would be:
///
/// ```dart
/// class MyWidget extends StatelessWidget {
///   MyWidget({Key key, this.child}): super(key: key);
///
///   final Widget child;
///
///   @override
///   Widget build(BuildContext context) {
///     return SomethingWidget(child: child);
///   }
/// }
/// ```
///
/// Whereas a [SingleChildStatelessWidget] would be:
///
/// ```dart
/// class MyWidget extends SingleChildStatelessWidget {
///   MyWidget({Key key, Widget child}): super(key: key, child: child);
///
///   @override
///   Widget buildWithChild(BuildContext context, Widget child) {
///     return SomethingWidget(child: child);
///   }
/// }
/// ```
///
/// This allows our new `MyWidget` to be used both with:
///
/// ```dart
/// MyWidget(
///   child: AnotherWidget(),
/// )
/// ```
///
/// and to be placed inside `children` of [Nested] like so:
///
/// ```dart
/// Nested(
///   children: [
///     MyWidget(),
///     ...
///   ],
///   child: AnotherWidget(),
/// )
/// ```
class Nested extends StatelessWidget implements SingleChildWidget {
  /// Allows configuring key, children and child
  Nested({
    Key key,
    @required List<SingleChildWidget> children,
    Widget child,
  })  : assert(children != null),
        assert(children != null && children.isNotEmpty),
        _children = children,
        _child = child,
        super(key: key);
  final List<SingleChildWidget> _children;
  final Widget _child;
  @override
  Widget build(BuildContext context) {
    throw StateError('implemented internally');
  }

  @override
  _NestedElement createElement() => _NestedElement(this);
}

class _NestedElement extends StatelessElement with SingleChildWidgetElementMixin {
  _NestedElement(Nested widget) : super(widget);
  @override
  Nested get widget => super.widget as Nested;
  final nodes = <_NestedHookElement>{};
  @override
  Widget build() {
    _NestedHook nestedHook;
    var nextNode = _parent?.injectedChild ?? widget._child;
    for (final child in widget._children.reversed) {
      nextNode = nestedHook = _NestedHook(
        owner: this,
        wrappedWidget: child,
        injectedChild: nextNode,
      );
    }
    if (nestedHook != null) {
      // We manually update _NestedHookElement instead of letter widgets do their thing
      // because an item N may be constant but N+1 not. So, if we used widgets
      // then N+1 wouldn't rebuild because N didn't change
      for (final node in nodes) {
        node
          ..wrappedChild = nestedHook.wrappedWidget
          ..injectedChild = nestedHook.injectedChild;
        final next = nestedHook.injectedChild;
        if (next is _NestedHook) {
          nestedHook = next;
        } else {
          break;
        }
      }
    }
    return nextNode;
  }
}

class _NestedHook extends StatelessWidget {
  _NestedHook({
    this.injectedChild,
    @required this.wrappedWidget,
    @required this.owner,
  });
  final SingleChildWidget wrappedWidget;
  final Widget injectedChild;
  final _NestedElement owner;
  @override
  _NestedHookElement createElement() => _NestedHookElement(this);
  @override
  Widget build(BuildContext context) => throw StateError('handled internally');
}

class _NestedHookElement extends StatelessElement {
  _NestedHookElement(_NestedHook widget) : super(widget);
  @override
  _NestedHook get widget => super.widget as _NestedHook;
  Widget _injectedChild;
  Widget get injectedChild => _injectedChild;
  set injectedChild(Widget value) {
    final previous = _injectedChild;
    if (value is _NestedHook &&
        previous is _NestedHook &&
        Widget.canUpdate(value.wrappedWidget, previous.wrappedWidget)) {
      // no need to rebuild the wrapped widget just for a _NestedHook.
      // The widget doesn't matter here, only its Element.
      return;
    }
    if (previous != value) {
      _injectedChild = value;
      visitChildren((e) => e.markNeedsBuild());
    }
  }

  SingleChildWidget _wrappedChild;
  SingleChildWidget get wrappedChild => _wrappedChild;
  set wrappedChild(SingleChildWidget value) {
    if (_wrappedChild != value) {
      _wrappedChild = value;
      markNeedsBuild();
    }
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    widget.owner.nodes.add(this);
    _wrappedChild = widget.wrappedWidget;
    _injectedChild = widget.injectedChild;
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    widget.owner.nodes.remove(this);
    super.unmount();
  }

  @override
  Widget build() {
    return wrappedChild;
  }
}

/// A [Widget] that takes a single descendant.
///
/// As opposed to [ProxyWidget], it may have a "build" method.
///
/// See also:
/// - [SingleChildStatelessWidget]
/// - [SingleChildStatefulWidget]
abstract class SingleChildWidget implements Widget {
  @override
  SingleChildWidgetElementMixin createElement();
}

mixin SingleChildWidgetElementMixin on Element {
  _NestedHookElement _parent;
  @override
  void mount(Element parent, dynamic newSlot) {
    if (parent is _NestedHookElement) {
      _parent = parent;
    }
    super.mount(parent, newSlot);
  }

  @override
  void activate() {
    super.activate();
    visitAncestorElements((parent) {
      if (parent is _NestedHookElement) {
        _parent = parent;
      }
      return false;
    });
  }
}

/// A [StatelessWidget] that implements [SingleChildWidget] and is therefore
/// compatible with [Nested].
///
/// Its [build] method must **not** be overriden. Instead use [buildWithChild].
abstract class SingleChildStatelessWidget extends StatelessWidget implements SingleChildWidget {
  /// Creates a widget that has exactly one child widget.
  const SingleChildStatelessWidget({Key key, Widget child})
      : _child = child,
        super(key: key);
  final Widget _child;

  /// A [build] method that receives an extra `child` parameter.
  ///
  /// This method may be called with a `child` different from the parameter
  /// passed to the constructor of [SingleChildStatelessWidget].
  /// It may also be called again with a different `child`, without this widget
  /// being recreated.
  Widget buildWithChild(BuildContext context, Widget child);
  @override
  Widget build(BuildContext context) => buildWithChild(context, _child);
  @override
  SingleChildStatelessElement createElement() {
    return SingleChildStatelessElement(this);
  }
}

/// An [Element] that uses a [SingleChildStatelessWidget] as its configuration.
class SingleChildStatelessElement extends StatelessElement with SingleChildWidgetElementMixin {
  /// Creates an element that uses the given widget as its configuration.
  SingleChildStatelessElement(SingleChildStatelessWidget widget) : super(widget);
  @override
  Widget build() {
    if (_parent != null) {
      return widget.buildWithChild(this, _parent.injectedChild);
    }
    return super.build();
  }

  @override
  SingleChildStatelessWidget get widget => super.widget as SingleChildStatelessWidget;
}

/// A [StatefulWidget] that is compatible with [Nested].
abstract class SingleChildStatefulWidget extends StatefulWidget implements SingleChildWidget {
  /// Creates a widget that has exactly one child widget.
  const SingleChildStatefulWidget({Key key, Widget child})
      : _child = child,
        super(key: key);
  final Widget _child;
  @override
  SingleChildStatefulElement createElement() {
    return SingleChildStatefulElement(this);
  }
}

/// A [State] for [SingleChildStatefulWidget].
///
/// Do not override [build] and instead override [buildWithChild].
abstract class SingleChildState<T extends SingleChildStatefulWidget> extends State<T> {
  /// A [build] method that receives an extra `child` parameter.
  ///
  /// This method may be called with a `child` different from the parameter
  /// passed to the constructor of [SingleChildStatelessWidget].
  /// It may also be called again with a different `child`, without this widget
  /// being recreated.
  Widget buildWithChild(BuildContext context, Widget child);
  @override
  Widget build(BuildContext context) => buildWithChild(context, widget._child);
}

/// An [Element] that uses a [SingleChildStatefulWidget] as its configuration.
class SingleChildStatefulElement extends StatefulElement with SingleChildWidgetElementMixin {
  /// Creates an element that uses the given widget as its configuration.
  SingleChildStatefulElement(SingleChildStatefulWidget widget) : super(widget);
  @override
  SingleChildStatefulWidget get widget => super.widget as SingleChildStatefulWidget;
  @override
  SingleChildState<SingleChildStatefulWidget> get state =>
      super.state as SingleChildState<SingleChildStatefulWidget>;
  @override
  Widget build() {
    if (_parent != null) {
      return state.buildWithChild(this, _parent.injectedChild);
    }
    return super.build();
  }
}

/// A [SingleChildWidget] that delegates its implementation to a callback.
///
/// It works like [Builder], but is compatible with [Nested].
class SingleChildBuilder extends SingleChildStatelessWidget {
  /// Creates a widget that delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const SingleChildBuilder({Key key, @required this.builder, Widget child})
      : assert(builder != null),
        super(key: key, child: child);

  /// Called to obtain the child widget.
  ///
  /// The `child` parameter may be different from the one parameter passed to
  /// the constructor of [SingleChildBuilder].
  final Widget Function(BuildContext context, Widget child) builder;
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return builder(context, child);
  }
}

mixin SingleChildStatelessWidgetMixin implements StatelessWidget, SingleChildStatelessWidget {
  Widget get child;
  @override
  Widget get _child => child;
  @override
  SingleChildStatelessElement createElement() {
    return SingleChildStatelessElement(this);
  }

  @override
  Widget build(BuildContext context) {
    return buildWithChild(context, child);
  }
}
mixin SingleChildStatefulWidgetMixin on StatefulWidget implements SingleChildWidget {
  Widget get child;
  @override
  _SingleChildStatefulMixinElement createElement() => _SingleChildStatefulMixinElement(this);
}
mixin SingleChildStateMixin<T extends StatefulWidget> on State<T> {
  Widget buildWithChild(BuildContext context, Widget child);
  @override
  Widget build(BuildContext context) {
    return buildWithChild(
      context,
      (widget as SingleChildStatefulWidgetMixin).child,
    );
  }
}

class _SingleChildStatefulMixinElement extends StatefulElement with SingleChildWidgetElementMixin {
  _SingleChildStatefulMixinElement(SingleChildStatefulWidgetMixin widget) : super(widget);
  @override
  SingleChildStatefulWidgetMixin get widget => super.widget as SingleChildStatefulWidgetMixin;
  @override
  SingleChildStateMixin<StatefulWidget> get state =>
      super.state as SingleChildStateMixin<StatefulWidget>;
  @override
  Widget build() {
    if (_parent != null) {
      return state.buildWithChild(this, _parent.injectedChild);
    }
    return super.build();
  }
}

mixin SingleChildInheritedElementMixin on InheritedElement, SingleChildWidgetElementMixin {
  @override
  Widget build() {
    if (_parent != null) {
      return _parent.injectedChild;
    }
    return super.build();
  }
}

class MultiProvider extends Nested {
  MultiProvider({
    Key key,
    @required List<SingleChildWidget> providers,
    Widget child,
  })  : assert(providers != null),
        super(key: key, children: providers, child: child);
}

class Provider<T> extends InheritedProvider<T> {
  Provider({
    Key key,
    @required Create<T> create,
    Dispose<T> dispose,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  })  : assert(create != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          dispose: dispose,
          debugCheckInvalidValueType: kReleaseMode
              ? null
              : (T value) => Provider.debugCheckInvalidValueType?.call<T>(value),
          child: child,
        );
  Provider.value({
    Key key,
    @required T value,
    UpdateShouldNotify<T> updateShouldNotify,
    ValueWidgetBuilder<T> builder,
    Widget child,
  })  : assert(() {
          Provider.debugCheckInvalidValueType?.call<T>(value);
          return true;
        }()),
        super.value(
          key: key,
          builder: builder,
          value: value,
          updateShouldNotify: updateShouldNotify,
          child: child,
        );
  static T of<T>(BuildContext context, {bool listen = true}) {
    assert(
      T != dynamic,
      '''
Tried to call Provider.of<dynamic>. This is likely a mistake and is therefore
unsupported.
If you want to expose a variable that can be anything, consider changing
`dynamic` to `Object` instead.
''',
    );
    assert(
      context.owner.debugBuilding || listen == false || _debugIsInInheritedProviderUpdate,
      '''
Tried to listen to a value exposed with provider, from outside of the widget tree.
This is likely caused by an event handler (like a button's onPressed) that called
Provider.of without passing `listen: false`.
To fix, write:
Provider.of<$T>(context, listen: false);
It is unsupported because may pointlessly rebuild the widget associated to the
event handler, when the widget tree doesn't care about the value.
''',
    );
    final inheritedElement = _inheritedElementOf<T>(context);
    if (listen) {
      context.dependOnInheritedElement(inheritedElement);
    }
    return inheritedElement.value;
  }

  static _InheritedProviderScopeMixin<T> _inheritedElementOf<T>(BuildContext context) {
    _InheritedProviderScopeMixin<T> inheritedElement;
    if (context.widget is _DefaultInheritedProviderScope<T>) {
      context.visitAncestorElements((parent) {
        inheritedElement =
            parent.getElementForInheritedWidgetOfExactType<_DefaultInheritedProviderScope<T>>()
                as _DefaultInheritedProviderScopeElement<T>;
        return false;
      });
    } else {
      inheritedElement =
          context.getElementForInheritedWidgetOfExactType<_DefaultInheritedProviderScope<T>>()
              as _DefaultInheritedProviderScopeElement<T>;
    }
    if (inheritedElement == null) {
      throw ProviderNotFoundException(T, context.widget.runtimeType);
    }
    return inheritedElement;
  }

  static void Function<T>(T value) debugCheckInvalidValueType = <T>(T value) {
    assert(() {
      if (value is Listenable || value is Stream) {
        throw FlutterError('''
Tried to use Provider with a subtype of Listenable/Stream ($T).
This is likely a mistake, as Provider will not automatically update dependents
when $T is updated. Instead, consider changing Provider for more specific
implementation that handles the update mechanism, such as:
- ListenableProvider
- ChangeNotifierProvider
- ValueListenableProvider
- StreamProvider
Alternatively, if you are making your own provider, consider using InheritedProvider.
If you think that this is not an error, you can disable this check by setting
Provider.debugCheckInvalidValueType to `null` in your main file:
```
void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}
```
''');
      }
      return true;
    }());
  };
}

class ProviderNotFoundException implements Exception {
  final Type valueType;
  final Type widgetType;
  ProviderNotFoundException(
    this.valueType,
    this.widgetType,
  );
  @override
  String toString() {
    return '''
Error: Could not find the correct Provider<$valueType> above this $widgetType Widget
To fix, please:
  * Ensure the Provider<$valueType> is an ancestor to this $widgetType Widget
  * Provide types to Provider<$valueType>
  * Provide types to Consumer<$valueType>
  * Provide types to Provider.of<$valueType>()
  * Always use package imports. Ex: `import 'package:my_app/my_code.dart';
  * Ensure the correct `context` is being used.
If none of these solutions work, please file a bug at:
''';
  }
}

extension ReadProvider on BuildContext {
  T read<T>() => Provider.of<T>(this, listen: false);
}

extension WatchProvider on BuildContext {
  T watch<T>() => Provider.of<T>(this);
}

typedef Locator = T Function<T>();
typedef ProviderBuilder<R> = Widget Function(
  BuildContext context,
  R value,
  Widget child,
);
typedef ProxyProviderBuilder<T, R> = R Function(
  BuildContext context,
  T value,
  R previous,
);
typedef ProxyProviderBuilder2<T, T2, R> = R Function(
  BuildContext context,
  T value,
  T2 value2,
  R previous,
);
typedef ProxyProviderBuilder3<T, T2, T3, R> = R Function(
  BuildContext context,
  T value,
  T2 value2,
  T3 value3,
  R previous,
);
typedef ProxyProviderBuilder4<T, T2, T3, T4, R> = R Function(
  BuildContext context,
  T value,
  T2 value2,
  T3 value3,
  T4 value4,
  R previous,
);
typedef ProxyProviderBuilder5<T, T2, T3, T4, T5, R> = R Function(
  BuildContext context,
  T value,
  T2 value2,
  T3 value3,
  T4 value4,
  T5 value5,
  R previous,
);
typedef ProxyProviderBuilder6<T, T2, T3, T4, T5, T6, R> = R Function(
  BuildContext context,
  T value,
  T2 value2,
  T3 value3,
  T4 value4,
  T5 value5,
  T6 value6,
  R previous,
);

class ProxyProvider0<R> extends InheritedProvider<R> {
  ProxyProvider0({
    Key key,
    Create<R> create,
    @required R Function(BuildContext context, R value) update,
    UpdateShouldNotify<R> updateShouldNotify,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(update != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          update: update,
          dispose: dispose,
          updateShouldNotify: updateShouldNotify,
          debugCheckInvalidValueType: kReleaseMode
              ? null
              : (R value) => Provider.debugCheckInvalidValueType?.call<R>(value),
          child: child,
        );
}

class ProxyProvider<T, R> extends ProxyProvider0<R> {
  ProxyProvider({
    Key key,
    Create<R> create,
    @required ProxyProviderBuilder<T, R> update,
    UpdateShouldNotify<R> updateShouldNotify,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(update != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          update: (context, value) => update(
            context,
            Provider.of(context),
            value,
          ),
          updateShouldNotify: updateShouldNotify,
          dispose: dispose,
          child: child,
        );
}

class ProxyProvider2<T, T2, R> extends ProxyProvider0<R> {
  ProxyProvider2({
    Key key,
    Create<R> create,
    @required ProxyProviderBuilder2<T, T2, R> update,
    UpdateShouldNotify<R> updateShouldNotify,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(update != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          update: (context, value) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            value,
          ),
          updateShouldNotify: updateShouldNotify,
          dispose: dispose,
          child: child,
        );
}

class ProxyProvider3<T, T2, T3, R> extends ProxyProvider0<R> {
  ProxyProvider3({
    Key key,
    Create<R> create,
    @required ProxyProviderBuilder3<T, T2, T3, R> update,
    UpdateShouldNotify<R> updateShouldNotify,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(update != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          update: (context, value) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            value,
          ),
          updateShouldNotify: updateShouldNotify,
          dispose: dispose,
          child: child,
        );
}

class ProxyProvider4<T, T2, T3, T4, R> extends ProxyProvider0<R> {
  ProxyProvider4({
    Key key,
    Create<R> create,
    @required ProxyProviderBuilder4<T, T2, T3, T4, R> update,
    UpdateShouldNotify<R> updateShouldNotify,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(update != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          update: (context, value) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            value,
          ),
          updateShouldNotify: updateShouldNotify,
          dispose: dispose,
          child: child,
        );
}

class ProxyProvider5<T, T2, T3, T4, T5, R> extends ProxyProvider0<R> {
  ProxyProvider5({
    Key key,
    Create<R> create,
    @required ProxyProviderBuilder5<T, T2, T3, T4, T5, R> update,
    UpdateShouldNotify<R> updateShouldNotify,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(update != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          update: (context, value) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            value,
          ),
          updateShouldNotify: updateShouldNotify,
          dispose: dispose,
          child: child,
        );
}

class ProxyProvider6<T, T2, T3, T4, T5, T6, R> extends ProxyProvider0<R> {
  ProxyProvider6({
    Key key,
    Create<R> create,
    @required ProxyProviderBuilder6<T, T2, T3, T4, T5, T6, R> update,
    UpdateShouldNotify<R> updateShouldNotify,
    Dispose<R> dispose,
    bool lazy,
    ValueWidgetBuilder<R> builder,
    Widget child,
  })  : assert(update != null),
        super(
          key: key,
          lazy: lazy,
          builder: builder,
          create: create,
          update: (context, value) => update(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            value,
          ),
          updateShouldNotify: updateShouldNotify,
          dispose: dispose,
          child: child,
        );
}

typedef ShouldRebuild<T> = bool Function(T previous, T next);

class Selector0<T> extends SingleChildStatefulWidget {
  Selector0({
    Key key,
    @required this.builder,
    @required this.selector,
    ShouldRebuild<T> shouldRebuild,
    Widget child,
  })  : assert(builder != null),
        assert(selector != null),
        _shouldRebuild = shouldRebuild,
        super(key: key, child: child);
  final ValueWidgetBuilder<T> builder;
  final T Function(BuildContext) selector;
  final ShouldRebuild<T> _shouldRebuild;
  @override
  _Selector0State<T> createState() => _Selector0State<T>();
}

class _Selector0State<T> extends SingleChildState<Selector0<T>> {
  T value;
  Widget cache;
  Widget oldWidget;
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    final selected = widget.selector(context);
    var shouldInvalidateCache = oldWidget != widget ||
        (widget._shouldRebuild != null && widget._shouldRebuild.call(value, selected)) ||
        (widget._shouldRebuild == null && value != selected);
    if (shouldInvalidateCache) {
      value = selected;
      oldWidget = widget;
      cache = widget.builder(
        context,
        selected,
        child,
      );
    }
    return cache;
  }
}

class Selector<A, S> extends Selector0<S> {
  Selector({
    Key key,
    @required ValueWidgetBuilder<S> builder,
    @required S Function(BuildContext, A) selector,
    ShouldRebuild<S> shouldRebuild,
    Widget child,
  })  : assert(selector != null),
        super(
          key: key,
          shouldRebuild: shouldRebuild,
          builder: builder,
          selector: (context) => selector(context, Provider.of(context)),
          child: child,
        );
}

class Selector2<A, B, S> extends Selector0<S> {
  Selector2({
    Key key,
    @required ValueWidgetBuilder<S> builder,
    @required S Function(BuildContext, A, B) selector,
    ShouldRebuild<S> shouldRebuild,
    Widget child,
  })  : assert(selector != null),
        super(
          key: key,
          shouldRebuild: shouldRebuild,
          builder: builder,
          selector: (context) => selector(
            context,
            Provider.of(context),
            Provider.of(context),
          ),
          child: child,
        );
}

class Selector3<A, B, C, S> extends Selector0<S> {
  Selector3({
    Key key,
    @required ValueWidgetBuilder<S> builder,
    @required S Function(BuildContext, A, B, C) selector,
    ShouldRebuild<S> shouldRebuild,
    Widget child,
  })  : assert(selector != null),
        super(
          key: key,
          shouldRebuild: shouldRebuild,
          builder: builder,
          selector: (context) => selector(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
          ),
          child: child,
        );
}

class Selector4<A, B, C, D, S> extends Selector0<S> {
  Selector4({
    Key key,
    @required ValueWidgetBuilder<S> builder,
    @required S Function(BuildContext, A, B, C, D) selector,
    ShouldRebuild<S> shouldRebuild,
    Widget child,
  })  : assert(selector != null),
        super(
          key: key,
          shouldRebuild: shouldRebuild,
          builder: builder,
          selector: (context) => selector(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
          ),
          child: child,
        );
}

class Selector5<A, B, C, D, E, S> extends Selector0<S> {
  Selector5({
    Key key,
    @required ValueWidgetBuilder<S> builder,
    @required S Function(BuildContext, A, B, C, D, E) selector,
    ShouldRebuild<S> shouldRebuild,
    Widget child,
  })  : assert(selector != null),
        super(
          key: key,
          shouldRebuild: shouldRebuild,
          builder: builder,
          selector: (context) => selector(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
          ),
          child: child,
        );
}

class Selector6<A, B, C, D, E, F, S> extends Selector0<S> {
  Selector6({
    Key key,
    @required ValueWidgetBuilder<S> builder,
    @required S Function(BuildContext, A, B, C, D, E, F) selector,
    ShouldRebuild<S> shouldRebuild,
    Widget child,
  })  : assert(selector != null),
        super(
          key: key,
          shouldRebuild: shouldRebuild,
          builder: builder,
          selector: (context) => selector(
            context,
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
            Provider.of(context),
          ),
          child: child,
        );
}

class ValueListenableProvider<T> extends DeferredInheritedProvider<ValueListenable<T>, T> {
  ValueListenableProvider({
    Key key,
    @required Create<ValueNotifier<T>> create,
    UpdateShouldNotify<T> updateShouldNotify,
    bool lazy,
    ValueWidgetBuilder<T> builder,
    Widget child,
  }) : super(
          key: key,
          create: create,
          lazy: lazy,
          builder: builder,
          updateShouldNotify: updateShouldNotify,
          startListening: _startListening(),
          dispose: _dispose,
          child: child,
        );
  ValueListenableProvider.value({
    Key key,
    @required ValueListenable<T> value,
    UpdateShouldNotify<T> updateShouldNotify,
    ValueWidgetBuilder<T> builder,
    Widget child,
  }) : super.value(
          key: key,
          builder: builder,
          value: value,
          updateShouldNotify: updateShouldNotify,
          startListening: _startListening(),
          child: child,
        );
  static void _dispose(BuildContext context, ValueListenable<Object> notifier) {
    if (notifier is ValueNotifier) {
      notifier.dispose();
    }
  }

  static DeferredStartListening<ValueListenable<T>, T> _startListening<T>() {
    return (_, setState, controller, __) {
      setState(controller.value);
      final listener = () => setState(controller.value);
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    };
  }
}
