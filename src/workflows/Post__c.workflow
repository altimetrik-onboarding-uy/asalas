<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Post_Rejected</fullName>
        <description>Email Post Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Post_review_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Notification_to_review_Post</fullName>
        <description>Notification to review Post</description>
        <protected>false</protected>
        <recipients>
            <recipient>admin@txileno.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MarketingProductInquiryResponse</template>
    </alerts>
    <alerts>
        <fullName>Review_was_approved</fullName>
        <description>Email Review was approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Post_Review_Approved</template>
    </alerts>
    <alerts>
        <fullName>send_under_review_alert</fullName>
        <description>send under review alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>admin@txileno.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Post_Under_Review_Aapproval</template>
    </alerts>
    <fieldUpdates>
        <fullName>Post_is_Ready</fullName>
        <description>Post was approved and is on Ready Status to publish it</description>
        <field>Status__c</field>
        <literalValue>Ready</literalValue>
        <name>Post is Ready</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Post_status_change_to_Draft</fullName>
        <description>Changing status post after it creation</description>
        <field>Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Post status change to Draft</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_Post</fullName>
        <description>Status change to Draft Again</description>
        <field>Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Rejected Post</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_set_to_Ready</fullName>
        <field>Status__c</field>
        <literalValue>Ready</literalValue>
        <name>Status set to Ready</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Post Creation Status</fullName>
        <actions>
            <name>Post_status_change_to_Draft</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Post__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>whenever a post is created, it status will change from draft to Under Review</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
