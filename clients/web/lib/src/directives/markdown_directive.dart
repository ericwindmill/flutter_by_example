import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:markdown/markdown.dart' as md;

@Directive(selector: '[markdown]')
class MarkdownDirective {
  final Element _el;

  @Input("markdown")
  String markdownString;

  MarkdownDirective(this._el) {
    _setInnerHtml(_el);
  }

  _setInnerHtml(Element _el) async {
    await new Timer(Duration(milliseconds: 1), () => null);
    final html = md.markdownToHtml(markdownString);
    _el.setInnerHtml(html);
  }
}
