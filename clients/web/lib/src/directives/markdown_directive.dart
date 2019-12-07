import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:markdown/markdown.dart' as md;

import './highlight.dart';

@Directive(selector: '[markdown]')
class MarkdownDirective {
  final Element _el;

  @Input("markdown")
  String markdownString;

  MarkdownDirective(this._el) {
    _setInnerHtml(_el);
  }

  void _highlightCodeBlocks() {
    final htmlDiv = querySelector('body') as BodyElement;

    for (var block in htmlDiv.querySelectorAll('pre code')) {
      print("yo: $block");
      try {
        highlightBlock(block);
      } catch (e) {
        window.console.error('Error highlighting markdown:');
        window.console.error(e);
      }
    }
  }

  _setInnerHtml(Element _el) async {
    await Timer(Duration(milliseconds: 1), () => null);
    final html = _el.setInnerHtml(
        md.markdownToHtml(markdownString, extensionSet: md.ExtensionSet.gitHubWeb),
        treeSanitizer: NullTreeSanitizer());
    _highlightCodeBlocks();
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
