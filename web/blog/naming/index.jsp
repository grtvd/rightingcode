<!-- Copyright © 2018 Robert S. Davidson All Rights Reserved. See LICENSE file for license information. -->
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../../includes/header.jsp">
	<jsp:param name="title" value="What's in a Name"/>
</jsp:include>
<body>
<jsp:include page="../../includes/navigation.jsp"/>

	<main role="main">
		<article class="post">
			<header>
				<h1>What's in a Name</h1>
				<time pubdate datetime="2018-03-23T12:00:00-04:00">March 23, 2018</time>
			</header>

			<p>What's in a name? Well, everything. As developers, we spend a great deal of time reading code, both
				our own and other developers' code. We should be able to jump back into code written last week, a
				year ago or 10 years ago and be able to easily read it. This all starts with good naming.</p>

			<p>Names should be chosen that make the code more readable. Avoid abbreviations, as they often make the code
				less readable and harder to understand. Indexes are one situation where bending this rule is OK (i.e.
				<code class="highlighter-rouge">i</code>, <code class="highlighter-rouge">j</code>,
				<code class="highlighter-rouge">k</code>). But <code class="highlighter-rouge">index</code> or
				<code class="highlighter-rouge">position</code> works just as well for these.
				<code class="highlighter-rouge">e</code> for Exception is normally fine too.</p>

			<p>Variable names should match the type name. For example, if I have a type call
				<code class="highlighter-rouge">Address</code>, the variable should be called
				<code class="highlighter-rouge">address</code> (or some variation, such as
				<code class="highlighter-rouge">fAddress</code> or <code class="highlighter-rouge">pAddress</code>).
				If I need to use two <code class="highlighter-rouge">Address</code> objects in the same scope, I may
				call one <code class="highlighter-rouge">homeAddress</code> and one
				<code class="highlighter-rouge">workAddress</code>.</p>


			<h3>Modelling Data</h3>

			<p>When creating type names, be careful to consider what data you are modelling. Choosing a bad name will
				haunt the code forever. For example, I was on an attorney case management system and there was a new
				requirement to support storing documents with the case. The developer was thinking about the action of
				<i>uploading</i> documents into the case system, so he named the data type
				<code class="highlighter-rouge">CaseUpload</code>. This is a very confusing name to other developers
				when they join the project. There is no indication that
				<code class="highlighter-rouge">CaseUpload</code> is actually about documents. And now there has been
				thousands of lines of code written that refer to <code class="highlighter-rouge">CaseUpload</code>. This
				in turn caused a ripple effect of related type names. When the developer needed to track document types,
				that type was named <code class="highlighter-rouge">CaseUploadType</code>. When the developer needed to
				track which documents were being actively edited, that type was named
				<code class="highlighter-rouge">CaseUploadEdit</code>.</p>

			<p>Another developer was tasked with sending information from the case system to an external client system.
				Someone had been calling this action <i>bridging</i>, as in bridging data between two systems. So the
				developer chose <code class="highlighter-rouge">BridgeQueue</code> to be the type for tracking a single
				piece of data to be bridged. This is not a great name. First, a <i>queue</i> is a list of things, not a
				single thing. Second, there is no information about <i>what</i> it is. The term <i>event</i> was being
				used to describe these things, so <code class="highlighter-rouge">BridgeEvent</code> would have been a
				better choice.</p>

			<p>In a related, intermediate system, the same developer named this same type
				<code class="highlighter-rouge">UploadQueue</code>. I'm assuming that it was because he was thinking
				about <i>uploading</i> this piece of data. I'm not sure why he didn't call it the same thing, he could
				have. <i>Uploading</i> and <i>downloading</i> are not great names for types. They are actions not data
				(and relative, point of view actions at that).</p>

			<p>These names are now locked into these systems forever. The level of effort and time to go back and change
				bad names is usually far too great.</p>


			<h3>Readable Names</h3>

			<p>Avoid shortening the variable name, such as <code class="highlighter-rouge">a</code> or
				<code class="highlighter-rouge">addr</code>. <code class="highlighter-rouge">a</code> has no value to
				readability whatsoever. <code class="highlighter-rouge">addr</code> might work, but
				<code class="highlighter-rouge">address</code> is clear and precise.</p>

			<p>A developer I know likes to use <code class="highlighter-rouge">returnVal</code> as the name for the
				variable that will be returned from a method. While the return part if obvious, it makes the heart of
				the method very much less readable. When reading his code, I find myself continually going back to
				review how <code class="highlighter-rouge">returnVal</code> is actually declared.</p>

			<p>Avoid using two variable names that only differ by 1 character. It becomes very easy to mix them up by
				mistake. For example, in baseball, there are right-handed and left-handed pitchers (and batters too
				BTW). They are often noted as LHP and RHP. Using names like <code class="highlighter-rouge">lhp</code>
				and <code class="highlighter-rouge">rhp</code> can get easily mixed up, causing a very subtle bug.
				<code class="highlighter-rouge">leftHandedPitcher</code> and
				<code class="highlighter-rouge">rightHandedPitcher</code> are better choices.</p>


			<h3>Maintain Conventions</h3>

			<p>It is important to be consistent with the use of camelcase, lowercase, or uppercase for types, enums and
				constants. Many programming languages have particular conventions, but the conventions are not required.
				Your team should choose a convention for your projects and consider it a requirement.</p>

			<p>A common convention is to use camelcase for type names, starting with an uppercase letter and camelcase
				for variable name, starting with a lowercase.</p>

<pre class="highlight"><code><span class="c1">// Prefer</span>
<span class="k">class <span class="kt">MemberAccount</span>
<span class="kt">MemberAccount</span> <span class="nv">memberAccount</span>;</span></code></pre>

<pre class="highlight"><code><span class="c1">// Avoid</span>
<span class="k">class <span class="kt">memberaccount</span>
class <span class="kt">MEMBER_ACCOUNT</span>
class <span class="kt">Member_Account</span>
<span class="kt">MemberAccount</span> <span class="nv">m</span>;
<span class="kt">MemberAccount</span> <span class="nv">acct</span>;
<span class="kt">MemberAccount</span> <span class="nv">MemberAccount</span>;</span></code></pre>

			<p>Conventions diverge for the use of constants. Some developers prefer to use all uppercase, with
				underscores as word separators. This can be fine, as long as readability is maintained. Some developers
				only partially follow this convention.</p>

<pre class="highlight"><code><span class="c1">// Prefer same convention</span>
<span class="k">enum <span class="kt">PermissionType</span>
{
&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">MANAGE_BUSINESS</span>,
&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">MANAGE_LOCATION</span>
}</span></code></pre>

<pre class="highlight"><code><span class="c1">// Avoid different conventions</span>
<span class="k">enum <span class="kt">PermissionType</span>
{
&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">manage_business</span>,
&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">ManageLocation</span>
}</span></code></pre>

			<p>I prefer to think of constants as member variables that happen to be read-only. My convention for
				constants matches my convention for member variables.  So then in Java for example, this allows my enums
				to be used in the same way as final members.</p>

<pre class="highlight"><code><span class="k">enum <span class="kt">AddressType</span>
{
&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">work</span>,
&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">home</span>
}</span></code></pre>

<pre class="highlight"><code><span class="k">class <span class="kt">AddressType</span>
{
&nbsp;&nbsp;&nbsp;&nbsp;static final <span class="kt">Integer</span> <span class="nv">work</span> = 0;
&nbsp;&nbsp;&nbsp;&nbsp;static final <span class="kt">Integer</span> <span class="nv">home</span> = 1;
}</span></code></pre>

			<p>These two type declarations result in the same use:</p>

<pre class="highlight"><code><span class="k">if (<span class="kt">AddressType</span>.<span class="nv">work</span>.equals(<span class="nv">addressType</span>))</span></code></pre>

			<h3>Conclusion</h3>

			<p>Choosing good names can be hard at times. Extra thought is needed to pick a good names, but the payoff
				will be far more maintainable systems for years to come.</p>

		</article>

	</main>

<jsp:include page="../../includes/footer.jsp"/>

</body>
</html>