<%@ page import="edu.chop.dgd.web.DisplayMapper" %><%@ page import="edu.chop.dgd.web.HttpRequestFacade" %><%@ page import="java.util.ArrayList" %><%@ page import="org.w3c.dom.*" %><%@ page import="sun.plugin.javascript.navig.*" %><%--  Created by IntelliJ IDEA.  User: jayaramanp  Date: 6/1/14  Time: 7:35 PM  To change this template use File | Settings | File Templates.--%><%    String pageTitle = "ANTHOLIGO - Oligo Design Application";    String headContent = "ANTHOLIGO - Oligo Design Application";    String pageDescription = "ANTHOLIGO - Oligo Design Application";%><%    HttpRequestFacade req= new HttpRequestFacade(request);    ArrayList error = (ArrayList) request.getAttribute("error");    DisplayMapper dm = new DisplayMapper(req, error);    String exampleFile = (String) request.getAttribute("exampleFile");%><script type="text/javascript">    function getProjectId(id){        var projectId = document.getElementById(id);        var projectName = projectId.value;        return projectName;    }    /*function validateForm(formId){        //alert("checking form now!");        var form = document.getElementById(formId);        var projectName = document.getElementById("proj_id");        var error = "";        if(projectName.value.length<1){            error += "Please enter a unique project name. Please upload file for given project name";            //alert(error);        }        if(error.length>1){            alert("Some fields need correction:\n" + error);            return false;        }else{            return true;        }    }*/    function validateFileUpload(){        valid = true;        if($("#file").val() == ''){            // your validation error action            error="no file uploaded. Please aupload your data file or the example file provided."            alert("Some fields need correction:\n" + error);            valid = false;        }        return valid //true or false    }    /*jQuery(function($) {        alert("hello");        $('input[type="file"]').change(function() {            alert($(this).val());            if ($(this).val()) {                error = false;                var filename = $(this).val();                $(this).closest('.fileinput-new').find('.file-name').html(filename);                if (error) {                    alert(error);                    parent.addClass('error').prepend.after('<div class="alert alert-error">' + error + '</div>');                }            }        });    });*/</script><jsp:include page="../common/header.jsp" flush="false">    <jsp:param name="projectTitle" value="ANTHOLIGO" />    <jsp:param name="pageTitle" value="<%=pageTitle%>"/>    <jsp:param name="logoImgPath" value="/Antholigo/resources/images/chop-logo_new.png"/></jsp:include><div class="container">    <div class="jumbotron" id="aboutDiv" style="border: inherit; padding-top: 5px; padding-left: 20px; padding-right: 20px; padding-bottom: 10px;">        <h3><a href="#About">About AnthOligo</a></h3>        <p class="form-group" style="font-size: medium">AnthOligo is a web-based application developed to automatically generate oligo sequences to be used for the            targeting and capturing the continuum of large and complex genomic regions. It automates the complex process of checking multiple applications so that the oligos selected successfully pass certain specific            parameter criteria and then get shortlisted as a possible use case for RSE (region specific extraction) processes.</p>        <p class="form-group" style="font-size: medium">The tools listed below create the perfect foil for AnthOligo to            <i><b>create magic</b></i> !</p>        <div class="tablist">            <ul class="custom-bullet" style="font-size: medium;">                <li>Primer3</li>                <li>BLAT</li>                <li>UNAFold (Mfold) - Hairpin, Homodimer, Heterodimer analysis</li>                <li>MapDB</li>                <li>Apache ActiveMQ</li>            </ul>        </div>    </div></div><div class="container">    <div class="jumbotron" id="uploadDiv" style="border: inherit; padding-top: 5px; padding-left: 20px; padding-right: 20px; padding-bottom: 10px;">        <h3><a href="#Run">Run AnthOligo</a></h3>        <form id="uploadForm1" data-toggle="validator" name="uploadForm" action="/Antholigo/oligo/fileUploadJobQueue.html"              onsubmit="return validateFileUpload('uploadForm1')" method="post" enctype="multipart/form-data">            <div class="form-group" style="padding-left: 5px">                <p style="font-size: medium">Please type a name for this project:</p>                <input class="form-control" id="proj_id" type="text" name="proj_id"                           placeholder="Enter name for project" value="<%=dm.out("proj_id", "")%>" required>            </div>            <div class="form-group" style="padding-left: 5px">                <p style="font-size: medium">Please type in your email address. Results will be emailed to you.</p>                <input class="form-control" id="email" type="email" name="email"                       placeholder="Enter email address" value="<%=dm.out("email", "dgdbfx@email.chop.edu")%>" required>            </div>            <div  class="form-group" data-toggle="radio" style="padding-left: 5px; font-size: medium; font-family: 'Ubuntu'">                <input type="radio" id="inlineCheckbox1" name="assembly" value="hg19" autocomplete="off" class="radio" checked="checked">                <label class="radio-inline" for="inlineCheckbox1">hg19</label>                <input type="radio" id="inlineCheckbox3" name="assembly" value="hg38" autocomplete="off" class="radio" checked="checked">                <label class="radio-inline" for="inlineCheckbox3">hg38</label>                <input type="radio" id="inlineCheckbox2" name="assembly" value="galGal4" autocomplete="off" class="radio">                <label class="radio-inline" for="inlineCheckbox2">galGal4</label>            </div>            <br />            <div class="form-group" style="font-style: italic; font-size: medium">Optional Parameters: </div>            <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#optionalParams" aria-expanded="true"                    aria-controls="optionalParams" style="font: 'Ubuntu', sans-serif;"><i class="glyphicon glyphicon-th-list"> Configure</i></button>            <br />            <div class="collapse" id="optionalParams">                <br />                <div  class="row">                    <div class="col-md-4">                        <div class="form-group">                            <label for="oligo_seq_separation" class="control-label">Sequence separation Size (Kbp)</label>                            <input id="oligo_seq_separation" type="number" min="7" max="20" name="oligo_seq_separation"                                   placeholder="size (Kbp)" value="<%=dm.out("oligo_seq_separation", "8")%>" size="10" required>                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="min_gc" class="control-label">Min GC %</label>                            <input id="min_gc" class="form-control" type="number" name="min_gc"                                   placeholder="Min GC%" min="1" max="100" value="<%=dm.out("min_gc", "35")%>" size="30" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="opt_gc" class="control-label">Opt GC %</label>                            <input id="opt_gc" class="form-control" type="number" name="opt_gc"                                   placeholder="Opt GC%" min="1" max="100" value="<%=dm.out("opt_gc", "50")%>" size="30" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="max_gc" class="control-label">Max GC %</label>                            <input id="max_gc" class="form-control" type="number" name="max_gc"                                   placeholder="Max GC%" min="1" max="100" value="<%=dm.out("max_gc", "65")%>" size="30" required>                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="min_tm">Min Tm</label>                            <input id="min_tm" class="form-control" type="text" name="min_tm"                                   placeholder="Min Temp(C)" pattern="^([0-9]{2}\.[0-9]{1})$" min="00.00" max="99.9" value="<%=dm.out("min_tm", "52.0")%>" size="30" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="opt_tm">Opt Tm</label>                            <input id="opt_tm" class="form-control" type="text" name="opt_tm"                                   placeholder="Opt Temp(C)" pattern="^([0-9]{2}\.[0-9]{1})$" min="00.00" max="99.9" value="<%=dm.out("opt_tm", "58.0")%>" size="30" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="max_tm">Max Tm</label>                            <input id="max_tm" class="form-control" type="text" name="max_tm"                                   placeholder="Max Temp(C)" pattern="^([0-9]{2}\.[0-9]{1})$" min="00.00" max="99.9" value="<%=dm.out("max_tm", "62.0")%>" size="30" required>                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="min_length">Min Size</label>                            <input id="min_length" class="form-control" type="number" min="15" max="50" name="min_length"                               value="<%=dm.out("min_length", "20")%>" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="opt_length">Opt Size</label>                            <input id="opt_length" class="form-control" type="number" min="15" max="50" name="opt_length"                                   value="<%=dm.out("opt_length", "25")%>" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="max_length">Max Size</label>                            <input id="max_length" class="form-control" type="number" min="15" max="50" name="max_length"                           value="<%=dm.out("max_length", "30")%>" required>                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="na">Na+ (mM)</label>                            <input id="na" class="form-control" type="text" name="na" pattern="^([0-9]{2}\.[0-9\{1})$" min="0.0" max="99.0" value="<%=dm.out("na", "50.0")%>" required>                        </div>                    </div>                    <div class="col-md-2  col-md-offset-1">                        <div class="form-group">                            <label for="mg">Mg2+ (mM)</label>                            <input id="mg" class="form-control" type="text" name="mg" pattern="^([0-9]{2}\.[0-9\{1})$" min="0.0" max="99.0" value="<%=dm.out("mg", "0.0")%>" required>                        </div>                    </div>                </div>                <!--blat_threshold-->                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="blat_threshold">BLAT min percentage identity threshold % </label>                            <input id="blat_threshold" class="form-control" type="text" name="blat_threshold" pattern="^([0-9]{2}\.[0-9\{1})$"                                   placeholder="BLAT min percentage identity (%)" min="88.0" max="99.0" value="<%=dm.out("na", "95.0")%>" required>                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="self_any">Self Any</label>                            <input id="self_any" class="form-control" type="text" name="self_any" pattern="^([0-9]{2}\.[0-9\{2})$" value="<%=dm.out("self_any", "4.00")%>" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="self_end">Self End</label>                            <input id="self_end" class="form-control" type="text" name="self_end" pattern="^([0-9]{2}\.[0-9\{2})$" value="<%=dm.out("self_end", "3.00")%>" required>                        </div>                    </div>                </div>                <div class="row">                    <div class="col-md-2">                        <div class="form-group">                            <label for="free_energy_hairpin">Hairpin Min Free Energy Threshold</label>                            <input id="free_energy_hairpin" class="form-control" type="number" name="free_energy_hairpin" pattern="^(-?\b[0-9]\b)$" min="-2" max="9" value="<%=dm.out("free_energy_hairpin", "-2")%>" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="free_energy_homodimer">Homodimer Min Free Energy Threshold</label> <%--Need to add max temp here too!--%>                            <input id="free_energy_homodimer" class="form-control" type="number" name="free_energy_homodimer" pattern="^(-?\b[0-9]\b|\b10\b)$" min="-10" max="9" value="<%=dm.out("free_energy_homodimer", "-10")%>" required>                        </div>                    </div>                    <div class="col-md-2 col-md-offset-1">                        <div class="form-group">                            <label for="free_energy_heterodimer">Heterodimer Min Free Energy Threshold</label>                            <input id="free_energy_heterodimer" class="form-control" type="number" name="free_energy_heterodimer" pattern="^(-?\b[0-9]\b|\b1[0-5]{1}\b)$" min="-15" max="9" value="<%=dm.out("free_energy_heterodimer", "-13")%>" required>                        </div>                    </div>                </div>            </div>            <br />            <div class="form-group">                <div class="fileinput-new" data-provides="fileinput">                <p class="file-input-names" style="font-size: medium">Please upload your file in a tab-delimited file.</p>                    <h4 style="font-size: medium">For help with file format or to download the example file, scroll up to find the <a href="/Antholigo/oligo/help.html">Help page</a> <span class="glyphicon glyphicon-link"></span></h4>                    <!--<input class="btn btn-file" id="file" type="file" name="file"/>-->                    <label for="file" class="btn btn-default">Select File</label>                    <input id="file" name="file" style="display: none !important;" accept=".txt" type="file" />                    <p class="file-name" id="file-name"></p>                </div>                <br />                <p style="font-size: medium">Submit project for processing and creation of oligos.</p>                    <input type="submit" class="btn btn-info" value="Upload File and Submit Job"/>                <br />            </div>        </form>    </div>    <%--</div>--%></div><script>    jQuery(function($) {        //alert("hello");        $('input[type="file"]').change(function() {            //alert($(this).val());            if ($(this).val()) {                error = false;                var filename = $(this).val().replace(/C:\\fakepath\\/i, '');                //alert(filename);                $(this).closest('.fileinput-new').find('.file-name').html(filename);                if (error) {                    alert(error);                    parent.addClass('error').prepend.after('<div class="alert alert-error">' + error + '</div>');                }            }        });    });</script><jsp:include page="../common/footer.jsp" flush="true">    <jsp:param name="contact" value="dgdbfx at email dot chop dot edu"/></jsp:include>