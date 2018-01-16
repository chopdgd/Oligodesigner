<%@ page import="edu.chop.dgd.web.DisplayMapper" %><%@ page import="edu.chop.dgd.web.HttpRequestFacade" %><%@ page import="java.util.ArrayList" %><%@ page import="org.w3c.dom.*" %><%@ page import="sun.plugin.javascript.navig.*" %><%--  Created by IntelliJ IDEA.  User: jayaramanp  Date: 6/1/14  Time: 7:35 PM  To change this template use File | Settings | File Templates.--%><%    String pageTitle = "ANTHOLIGO - Oligo Design Application";    String headContent = "ANTHOLIGO - Oligo Design Application";    String pageDescription = "ANTHOLIGO - Oligo Design Application";%><%    HttpRequestFacade req= new HttpRequestFacade(request);    ArrayList error = (ArrayList) request.getAttribute("error");    DisplayMapper dm = new DisplayMapper(req, error);    String exampleFile = (String) request.getAttribute("exampleFile");%><script type="text/javascript">    function getProjectId(id){        var projectId = document.getElementById(id);        var projectName = projectId.value;        return projectName;    }    function validateForm(formId){        //alert("checking form now!");        var form = document.getElementById(formId);        var projectName = document.getElementById("proj_id");        var error = "";        if(projectName.value.length<1){            error += "Please enter a unique project name. Please upload file for given project name";            //alert(error);        }        if(error.length>1){            alert("Some fields need correction:\n" + error);            return false;        }else{            return true;        }    }    function validateFileUpload(){        valid = true;        if($("#file").val() == ''){            // your validation error action            error="no file uploaded. Please aupload your data file or the example file provided."            alert("Some fields need correction:\n" + error);            valid = false;        }        return valid //true or false    }</script><jsp:include page="../common/header.jsp" flush="false">    <jsp:param name="projectTitle" value="ANTHOLIGO" />    <jsp:param name="pageTitle" value="<%=pageTitle%>"/>    <jsp:param name="logoImgPath" value="/Antholigo/resources/images/chop-logo_new.png"/></jsp:include><div class="container">    <div class="jumbotron" id="aboutDiv" style="border: thin; padding-top: 5px; padding-left: 20px; padding-right: 20px">        <h3>About AnthOligo</h3>        <p style="font-size: small">AnthOligo is a web-based application developed to automatically generate oligo sequences to be used for        the targeting and capturing the continuum of large and complex genomic regions. It automates the complex        process of checking multiple applications so that the oligos selected successfully pass certain specific        parameter criteria and then get shortlisted as a possible use case for RSE (region specific extraction)        processes. The oligos generated are processed by the following applications and filtered via AnthOligo to        give the end user an optimal set of oligos:</p>        <div class="tablist">            <ul>                <li>Primer3</li>                <li>BLAT</li>                <li>UNAFold (MFold)</li>            </ul>        </div>    </div></div><div class="container">    <div class="jumbotron" id="uploadDiv" style="border: inset; padding-top: 5px; padding-left: 20px; padding-right: 20px">        <form id="uploadForm1" data-toggle="validator" name="uploadForm" action="/Antholigo/oligo/fileUploadJobQueue.html"              onsubmit="return validateFileUpload('uploadForm1')" method="post" enctype="multipart/form-data">            <div class="form-group" style="padding-left: 5px">                <p><h4>Please type a name for this project.</h4></p>                <input class="form-control" id="proj_id" type="text" name="proj_id"                           placeholder="Enter name for project" value="<%=dm.out("proj_id", "")%>" required>            </div>            <div class="form-group" style="padding-left: 5px">                <p>Please type in your email address. Results will be emailed to you.</p>                <input class="form-control" id="email" type="email" name="email"                       placeholder="Enter email address" value="<%=dm.out("email", "dgdbfx@email.chop.edu")%>" required>            </div>            <div  class="form-group" style="padding-left: 5px">                <input type="radio" id="inlineCheckbox1" name="assembly" value="hg19" class="radio">                <label class="radio-inline" for="inlineCheckbox1">hg19</label>                <input type="radio" id="inlineCheckbox2" name="assembly" value="galGal4" class="radio">                <label class="radio-inline" for="inlineCheckbox1">galGal4</label>            </div>            <div class="form-group" style="font-weight: bolder">Optional Parameters:</div>            <div class="glyphicon glyphicon-th-list" data-toggle="collapse" data-target="#optionalParams" aria-expanded="false"                 aria-controls="optionalParams"> click to see Parameters</div>            <div class="collapse" id="optionalParams">                <br />                <div  class="row">                    <div class="col-md-4">                        <div class="form-group">                            <label for="oligo_seq_separation" class="control-label">Sequence separation Size (Kbp)</label>                            <input id="oligo_seq_separation" type="number" min="7" max="20" name="oligo_seq_separation"                                   placeholder="size (Kbp)" value="<%=dm.out("oligo_seq_separation", "8")%>" required>                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="min_gc">Min GC %</label>l                            <input id="min_gc" type="number" name="min_gc"                                   placeholder="Min GC%" min="1" max="100" value="<%=dm.out("min_gc", "35")%>" size="30">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="opt_gc">Opt GC %</label>                            <input id="opt_gc" type="number" name="opt_gc"                                   placeholder="Opt GC%" min="1" max="100" value="<%=dm.out("opt_gc", "50")%>" size="30">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="max_gc">Max GC %</label>                            <input id="max_gc" type="number" name="max_gc"                                   placeholder="Max GC%" min="1" max="100" value="<%=dm.out("max_gc", "65")%>" size="30">                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="min_tm">Min Tm</label>                            <input id="min_tm" type="text" name="min_tm"                                   placeholder="Min Temp(C)" pattern="^([0-9]{2}\.[0-9]{1})$" value="<%=dm.out("min_tm", "52.0")%>" size="30">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="opt_tm">Opt Tm</label>                            <input id="opt_tm" type="text" name="opt_tm"                                   placeholder="Opt Temp(C)" pattern="^([0-9]{2}\.[0-9]{1})$" value="<%=dm.out("opt_tm", "58.0")%>" size="30">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="max_tm">Max Tm</label>                            <input id="max_tm" type="text" name="max_tm"                                   placeholder="Max Temp(C)" pattern="^([0-9]{2}\.[0-9]{1})$" value="<%=dm.out("max_tm", "62.0")%>" size="30">                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="min_length">Min Size</label>                            <input id="min_length" type="number" min="15" max="50" name="min_length"                               value="<%=dm.out("min_length", "20")%>">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="opt_length">Opt Size</label>                            <input id="opt_length" type="number" min="15" max="50" name="opt_length"                                   value="<%=dm.out("opt_length", "25")%>">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="max_length">Max Size</label>                            <input id="max_length" type="number" min="15" max="50" name="max_length"                           value="<%=dm.out("max_length", "30")%>">                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="na">Na+ (mM)</label>                            <input id="na" type="text" name="na" pattern="([0-9]{2}\.[0-9\{1})" value="<%=dm.out("na", "50.0")%>">                        </div>                    </div>                    <div class="col-md-2  col-md-offset-1">                        <div class="form-group">                            <label for="mg">Mg2+ (mM)</label>                            <input id="mg" type="text" name="mg" pattern="([0-9]{2}\.[0-9\{1})" value="<%=dm.out("mg", "0.0")%>">                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="self_any">Self Any</label>                            <input id="self_any" type="text" name="self_any" pattern="([0-9]{2}\.[0-9\{2})" value="<%=dm.out("self_any", "4.00")%>">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="self_end">Self End</label>                            <input id="self_end" type="text" name="self_end" pattern="([0-9]{2}\.[0-9\{2})" value="<%=dm.out("self_end", "3.00")%>">                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="free_energy_hairpin">Hairpin Min Free Energy Threshold</label>                            <input id="free_energy_hairpin" type="number" name="free_energy_hairpin" pattern="(-?\b[0-9]\b)" min="-2" max="9" value="<%=dm.out("free_energy_hairpin", "-2")%>">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="free_energy_homodimer">Homodimer Min Free Energy Threshold</label> <%--Need to add max temp here too!--%>                            <input id="free_energy_homodimer" type="number" name="free_energy_homodimer" pattern="(-?\b[0-9]\b|\b10\b)" min="-10" max="9" value="<%=dm.out("free_energy_homodimer", "-10")%>">                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="free_energy_heterodimer">Heterodimer Min Free Energy Threshold</label>                            <input id="free_energy_heterodimer" type="number" name="free_energy_heterodimer" pattern="(-?\b[0-9]\b|\b1[0-5]{1}\b)" min="-15" max="9" value="<%=dm.out("free_energy_heterodimer", "-13")%>">                        </div>                    </div>                </div>            </div>            <br />            <div class="container">                <div class="form-group">                    <div>                        <p>Please upload your file with coordinates separated by tab.                            (Scroll down below for an example file you can use)</p>                            <input id="file" type="file" class="button" name="file"/>                        <br />                        <p>Submit project for processing and creation of oligos.</p>                            <input type="submit" class="btn btn-primary navbar-btn" value="Upload File"/>                        <br />                    </div>                </div>            </div>        </form>    </div>    <%--</div>--%></div><div class="container">    <%--<div class="col-sm-5 col-md-4" style="padding-right: 20px">--%>        <div class="jumbotron" id="AnthOligoHelp" style="border: inset; padding-top: 10px; padding-left: 20px; padding-right: 20px">            <p class="thumbnail">                For an example please use sample file provided here to test the application. Your input file needs to be                tab delimited text file with three columns.                <div class="tablist">                    <ul>                        <li>The first column consists of the Chromosome. please remember to add the "chr" tag prefix to                            your chromosome number. </li>                        <li>The second column consists of the start position of your region of interest. </li>                        <li>The third column consists of the end position of your region of interest. </li>                    </ul>                </div>                <div class="link"><a href="/Antholigo/oligo/FileDownload.html?file=<%=exampleFile%>&object=oligo">Use this example input file</a></div>            </p>        </div>    <%--</div>--%></div><jsp:include page="../common/footer.jsp" flush="true">    <jsp:param name="contact" value="dgdbfx at email dot chop dot edu"/></jsp:include>