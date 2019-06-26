import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';

enum SpinkitType { Wave }
enum NetworkState { success, fail, loading }

class NetworkMiddleware extends StatefulWidget {
  final String loadText;
  final Widget child;
  final Function reqfun;
  final double margin;
  final _NetworkMiddleware _networkMiddleware = _NetworkMiddleware();

  NetworkMiddleware(
      {this.loadText: '努力加载中...',
      this.child,
      this.margin,
      @required this.reqfun});

  require() => _networkMiddleware._req();

  @override
  State<StatefulWidget> createState() {
    return _networkMiddleware;
  }
}

class _NetworkMiddleware extends State<NetworkMiddleware> {
  NetworkState state = NetworkState.loading;
  DioErrorType errorType;

  @override
  Widget build(BuildContext context) {
    if (widget?.child != null) {
      return widget.child;
    } else {
      return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[_setPlaceholder()],
            )
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _req();
      _networkConnectStateListen();
    }
  }

  _networkConnectStateListen() {}

  _setPlaceholder() {
    return Container(
      margin: widget.margin ?? EdgeInsets.only(top: 28, bottom: 28),
      child: Column(
        children: <Widget>[_setContent()],
      ),
    );
  }

  _setContent() {
    Widget widget;
    switch (state) {
      case NetworkState.fail:
        widget = _fail(errorType);
        break;
      case NetworkState.loading:
        widget = _loading();
        break;
      case NetworkState.success:
        widget = _success();
        break;
    }

    return widget;
  }

  _loading() {
    return Row(children: <Widget>[
      SpinKitWave(
        color: Theme.of(context).primaryColor,
        type: SpinKitWaveType.start,
        size: 14,
      ),
      Container(
        margin: EdgeInsets.only(left: 6),
        child: Text(widget.loadText, style: TextStyle(color: Colors.black45)),
      )
    ]);
  }

  _success() {
    return widget.child ?? Text("请求成功");
  }

  _fail(errorType) {
    String text = '';

    switch (errorType) {
      // 网络未连接，发生在连接之前，Default error type, usually occurs before connecting the server.
      case DioErrorType.DEFAULT:
        text = '请连接网络后点击屏幕';
        break;
      // 连接超时
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        text = '加载失败，请点击重试';
        break;
    }
    return InkWell(
      onTap: () {
        _req();
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.black38),
      ),
    );
  }

  _req() async {
    var result;
    _setNetworkState(NetworkState.loading);

    try {
      result = await widget.reqfun();
    } on DioError catch (e) {
      if (e?.type != null) {
        errorType = e.type;
      }
      _setNetworkState(NetworkState.fail);
    }

    if (result != null) {
      _setNetworkState(NetworkState.success);
    }
  }

  _setNetworkState(NetworkState networkState) {
    if (mounted) {
      setState(() {
        state = networkState;
      });
    } else {
      state = networkState;
    }
  }
}
