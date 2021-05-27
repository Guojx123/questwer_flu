import 'package:fish_redux/fish_redux.dart';
import 'package:questwer_flu/global/state.dart';
import 'package:questwer_flu/global/store.dart';

import 'feedback/page.dart';

class FishRoute {

  static AbstractRoutes getRoute() {
    final AbstractRoutes routes = PageRoutes(
      pages: {
        SubmitFeedbackPage.NAME : SubmitFeedbackPage()
      },
      visitor: (String path, Page<Object, dynamic> page) {
        /// 只有特定的范围的 Page 才需要建立和 AppStore 的连接关系
        /// 满足 Page<T> ，T 是 GlobalBaseState 的子类
        if (page.isTypeof<GlobalBaseState>()) {
          /// 建立 AppStore 驱动 PageStore 的单向数据连接
          /// 1. 参数1 AppStore
          /// 2. 参数2 当 AppStore.state 变化时, PageStore.state 该如何变化
          page.connectExtraStore<GlobalState>(GlobalStore.store,
                  (Object pageState, GlobalState appState) {
                final GlobalBaseState p = pageState;
                if (pageState is Cloneable) {
                  final Object copy = pageState.clone();
                  final GlobalBaseState newState = copy;
                  if (p.themeColor != appState.themeColor) {
                    newState.themeColor = appState.themeColor;
                  }
                  return newState;
                }
                return pageState;
              });
        }

        /// AOP
        /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
        /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
        // page.enhancer.append(
        //   /// View AOP
        //   viewMiddleware: <ViewMiddleware<dynamic>>[
        //     safetyView<dynamic>(),
        //   ],
        //
        //   /// Adapter AOP
        //   adapterMiddleware: <AdapterMiddleware<dynamic>>[
        //     safetyAdapter<dynamic>()
        //   ],
        //
        //   /// Effect AOP
        //   effectMiddleware: <EffectMiddleware<dynamic>>[
        //     _pageAnalyticsMiddleware<dynamic>(),
        //   ],
        //
        //   /// Store AOP
        //   middleware: <Middleware<dynamic>>[
        //     logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        //   ],
        // );
      },
    );
    return routes;
  }
}