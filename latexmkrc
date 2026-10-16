# 出力ディレクトリ（LaTeX Workshop との整合のため）
$out_dir = '.';

# pLaTeX / pBibTeX / dvipdfmx を使用して DVI 経由で PDF を作成
$latex = 'platex';
$bibtex = 'pbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$pdf_mode = 3;

# 参考文献ファイル(.bbl)が空（\bibitem を含まない）のまま残っていると、
# latexmk は bibtex を再実行せず LaTeX エラー（missing \item）で停止し、
# PDF が更新されなくなる。そのような .bbl はビルド前に削除して再生成させる。
foreach my $bbl_file (glob("*.bbl")) {
    open(my $fh, '<', $bbl_file) or next;
    local $/;
    my $bbl_content = <$fh>;
    close($fh);
    unlink($bbl_file) if !defined($bbl_content) || $bbl_content !~ /\\bibitem/;
}
