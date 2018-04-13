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
				<code>i</code>, <code>j</code>, <code>k</code>). But <code>index</code> or <code>position</code> works
				just as well for these. <code>e</code> for Exception is normally fine too.</p>

			<p>Variable names should match the type name. For example, if I have a type call <code>Address</code>, the
				variable should be called <code>address</code> (or some variation, such as <code>fAddress</code> or
				<code>pAddress</code>). If I need to use two <code>Address</code> objects in the same scope, I may call
				one <code>homeAddress</code> and one <code>workAddress</code>.</p>


			<h3>Modeling Data</h3>

			<p>When creating type names, be careful to consider what data you are modeling. Choosing a bad name will
				haunt the code forever. For example, I was on an attorney case management system and there was a new
				requirement to support storing documents with the case. The developer was thinking about the action of
				<i>uploading</i> documents into the case system, so he named the data type <code>CaseUpload</code>. This
				is a very confusing name to other developers when they join the project. There is no indication that
				<code>CaseUpload</code> is actually about documents. And now there have been thousands of lines of code
				written that refer to <code>CaseUpload</code>. This in turn caused a ripple effect of related type
				names. When the developer needed to track document types, that type was named
				<code>CaseUploadType</code>. When the developer needed to track which documents were being actively
				edited, that type was named <code>CaseUploadEdit</code>.</p>

			<p>Another developer was tasked with sending information from the case system to an external client system.
				Someone had been calling this action <i>bridging</i>, as in bridging data between two systems. So the
				developer chose <code>BridgeQueue</code> to be the type for tracking a single piece of data to be
				bridged. This is not a great name. First, a <i>queue</i> is a list of things, not a single thing.
				Second, there is no information about <i>what</i> it is. The term <i>event</i> was being used to
				describe these things, so <code>BridgeEvent</code> would have been a better choice.</p>

			<p>In a related, intermediate system, the same developer named this same type
				<code>UploadQueue</code>. I'm assuming that it was because he was thinking about <i>uploading</i> this
				piece of data. I'm not sure why he didn't call it the same thing, he could have. <i>Uploading</i> and
				<i>downloading</i> are not great names for types. They are actions not data (and relative, point of view
				actions at that).</p>

			<p>These names are now locked into these systems forever. The level of effort and time to go back and change
				bad names is usually far too great.</p>


			<h3>Readable Names</h3>

			<p>Avoid shortening the variable name, such as <code>a</code> or <code>addr</code>. <code>a</code> has no
				value to readability whatsoever. <code>addr</code> might work, but <code>address</code> is clear and
				precise.</p>

			<p>A developer I know likes to use <code>returnVal</code> as the name for the variable that will be returned
				from a method. While the return part if obvious, it makes the heart of the method very much less
				readable. When reading his code, I find myself continually going back to review how
				<code>returnVal</code> is actually declared.</p>

			<p>Avoid using two variable names that only differ by 1 character. It becomes very easy to mix them up by
				mistake. For example, in baseball, there are right-handed and left-handed pitchers (and batters too
				BTW). They are often noted as LHP and RHP. Using names like <code>lhp</code> and <code>rhp</code> can
				get easily mixed up, causing a very subtle bug. <code>leftHandedPitcher</code> and
				<code>rightHandedPitcher</code> are better choices.</p>


			<h3>Maintain Conventions</h3>

			<p>It is important to be consistent with the use of camelcase, lowercase, or uppercase for types, enums and
				constants. Many programming languages have particular conventions, but the conventions are not required.
				Your team should choose a convention for your projects and consider it a requirement.</p>

			<p>A common convention is to use camelcase for type names, starting with an uppercase letter and camelcase
				for variable name, starting with a lowercase.</p>

<pre class="highlight"><code><span class="code-comment">// Prefer</span>
class <span class="code-type">MemberAccount</span>
<span class="code-type">MemberAccount</span> <span class="code-variable">memberAccount</span>;</code></pre>

<pre class="highlight"><code><span class="code-comment">// Avoid</span>
class <span class="code-type">memberaccount</span>
class <span class="code-type">MEMBER_ACCOUNT</span>
class <span class="code-type">Member_Account</span>
<span class="code-type">MemberAccount</span> <span class="code-variable">m</span>;
<span class="code-type">MemberAccount</span> <span class="code-variable">acct</span>;
<span class="code-type">MemberAccount</span> <span class="code-variable">MemberAccount</span>;</code></pre>

			<p>Conventions diverge for the use of constants. Some developers prefer to use all uppercase, with
				underscores as word separators. This can be fine, as long as readability is maintained. Some developers
				only partially follow this convention.</p>

<pre class="highlight"><code><span class="code-comment">// Prefer same convention</span>
enum <span class="code-type">PermissionType</span>
{
    <span class="code-variable">MANAGE_BUSINESS</span>,
    <span class="code-variable">MANAGE_LOCATION</span>
}</code></pre>

<pre class="highlight"><code><span class="code-comment">// Avoid different conventions</span>
enum <span class="code-type">PermissionType</span>
{
    <span class="code-variable">manage_business</span>,
    <span class="code-variable">ManageLocation</span>
}</code></pre>

			<p>I prefer to think of constants as member variables that happen to be read-only. My convention for
				constants matches my convention for member variables.  So then in Java for example, this allows my enums
				to be used in the same way as final members.</p>

<pre class="highlight"><code>enum <span class="code-type">AddressType</span>
{
    <span class="code-variable">work</span>,
    <span class="code-variable">home</span>
}</code></pre>

<pre class="highlight"><code>class <span class="code-type">AddressType</span>
{
    static final <span class="code-variable">Integer</span> <span class="code-variable">work</span> = 0;
    static final <span class="code-variable">Integer</span> <span class="code-variable">home</span> = 1;
}</code></pre>

			<p>These two type declarations result in the same use:</p>

<pre class="highlight"><code>if (<span class="code-type">AddressType</span>.<span class="code-variable">work</span>.equals(<span class="code-variable">addressType</span>))</code></pre>

			<h3>Conclusion</h3>

			<p>Choosing good names can be hard at times. Extra thought is needed to pick good names, but the payoff will
				be far more maintainable systems for years to come.</p>

		</article>

	</main>

<jsp:include page="../../includes/footer.jsp"/>

</body>
</html>